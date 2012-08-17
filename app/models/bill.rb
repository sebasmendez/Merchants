class Bill < ActiveRecord::Base
  require 'serialport'
  
  after_save :plus_amount_to_monthly, :plus_to_client_spend, :send_to_print
  #validates
  
  validates :barcode, :uniqueness => true
  validates :barcode, :amount, :presence => true
  validates :amount, :numericality => {:greater_than => 0 }
  
  #relations
  belongs_to :client
  belongs_to :order

  attr_accessor :uic, :uic_type, :client_kind
  #Methods
  def initialize (attributes = nil, options = {})
    super(attributes, options)
    self.barcode ||= (Bill.order('barcode DESC').first.try(:barcode) || 0) + 1
    self.bill_kind ||= 'B'
  end
  
  def plus_amount_to_monthly
    
    @bill = Bill.order('id DESC').first
    @monthly = Monthly.find_or_create_by_month_and_year(@bill.created_at.month, @bill.created_at.year)
    @monthly.sold ||= 0
    @monthly.sold += @bill.amount
    @monthly.update_attributes(sold: @monthly.sold)
  end
  
  def plus_to_client_spend
    @bill = Bill.order('id DESC').first
    if @bill.client_id
    @client = Client.find(@bill.client_id) 
    @client.spend += @bill.amount
    @client.update_attributes(spend: @client.spend)
    end
  end

  def send_to_print
    @@seq = rand(32..127)

    self.order.tap do |o|
      if o.client_id.present?
        o.client.tap do |c|
          if o.bill_kind.upcase == 'B'
            send_package(
              0x60, [
                'T', 'C', 'B', '1', 'P', '17','I', 'F',
                c.name, c.last_name, 'DNI', c.document, 'N', 
                c.address.first(40), c.location.first(40), c.location[40..-1] , 'C'
              ]
            )
            o.line_items.each do |li|
              send_package(0x62, line_item_for_bill(li))
              sleep 1
            end
            send_package(0x63, ['P'])
            sleep 2
            send_package(0x64, ['Su pago', o.price.to_f.round, 'T'])
            sleep 2
            send_package(0x65, ['T', 'B', 'Pago'])
          end
        end
      else
        send_package(0x40, []) # Open fiscal bill
        sleep 1

        o.line_items.each do |li|
          send_package( 0x42, line_item_for_bill(li)) # Add each item
        end

        send_package(0x44, ['Su pago', o.price.to_f.round, 'T']) # Send paid
        sleep 1

        send_package(0x45, ['T']) # Finish bill
      end
    end
  end

  def increase_sequence
    @@seq += 1
    @@seq = 32 if @@seq > 127
  end
  
  def send_package(code, parameters)
    port = SerialPort.open('/dev/ttyUSB0')

    separated_params = []
    
    if parameters.present?
      parameters.each do |e| # Add the 0x1c separator between elements
        # if e.present?
          separated_params << 0x1c
          if e.to_s.length == 1
            separated_params << e.ord
          elsif e.to_s.length > 1
            e.to_s.split(//).each { |l| separated_params << l.ord }
          end
        # end
      end
    end
    
    package = [0x02, @@seq, code, separated_params, 0x03]
    hex_sum = '%04x' % package.flatten!.inject(0) { |t, b| t + b.ord } # Calc Checksum

    hex_sum.bytes { |b| package << b } # Add Checksum
    p package
    package.each { |b| port.putc b } # Send to print
    sleep 2

    increase_sequence
  end

  def line_item_for_bill(li)
    [
      li.product.name.first(26),
      (li.quantity * 1000).to_f.round,
      li.price.to_f.round(2), '2100', 'M', '1', '0', '0'
    ]
  end
end
