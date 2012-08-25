class Bill < ActiveRecord::Base
  require 'serialport'
  @@seq = rand(95) + 32
  
  after_save :plus_amount_to_monthly, :plus_to_client_spend, :send_to_print
  #validates
  
  validates :barcode, :uniqueness => true
  validates :barcode, :amount, :presence => true
  validates :amount, :numericality => {:greater_than => 0 }
  
  #relations
  belongs_to :client
  belongs_to :order

  attr_accessor :uic, :uic_type

  #Methods
  def initialize (attributes = nil, options = {})
    super(attributes, options)
    self.barcode ||= (Bill.order('barcode DESC').first.try(:barcode) || 0) + 1
    self.bill_kind ||= 'B'
  end
  
  def plus_amount_to_monthly
    bill = Bill.order('id DESC').first

    monthly = Monthly.find_or_create_by_month_and_year(
      bill.created_at.month, bill.created_at.year
    )

    monthly.sold ||= 0
    monthly.sold += bill.amount
    monthly.update_attributes(sold: monthly.sold)
  end
  
  def plus_to_client_spend
    bill = Bill.order('id DESC').first

    if bill.client_id
      client = Client.find(bill.client_id) 
      client.spend += bill.amount
      client.update_attributes(spend: client.spend)
    end
  end

  def send_to_print
    self.order.tap do |o|
      self.client_kind.tap do |c_k| # A-B-C-X

        if o.client_id.present?
          o.client.tap do |c|
            send_package(
              0x60, [
                'T', 'C', self.bill_kind, '1', 'P', '17','I', c_k,
                c.name, c.last_name,
                (c_k != 'F' && c.uic_type ? c.uic_type : 'DNI'), 
                (c_k != 'F' && c.uic_type ? c.uic.delete('-') : c.document),
                'N', c.address.first(40), c.address[40..80].to_s,
                c.location.first(40),
                (c_k != 'F' ? "Orden Nro: #{self.order_id}" : '')
              ]
            )
            sleep 2
          end
        else
          send_package(
            0x60, ['T', 'C', 'B', '1', 'P', '17','I', 'F']
          ) # Open TF - B 3 segundos
          sleep 1
        end

        o.line_items.each do |li|
          send_package(0x62, line_item_for_bill(li, self.bill_kind)) # Add each item
        end

        if self.discount > 0
          pay_discount = (o.price * self.discount).round.to_i
          to_pay = ((o.price - pay_discount / 100).round(2) * 100).to_i
          
          send_package(0x62, [
                'DESCUENTO',
                1000,
                pay_discount, '2100', 'R', '1', '0', '', '', ''
              ])
          sleep 1
          send_package(0x64, ['Su pago', to_pay, 'T'])
          sleep 1
        else
          send_package(0x64, ['Su pago', o.price.to_f.round, 'T']) # Send paid
          sleep 1
        end
        send_package(0x65, ['T', self.bill_kind]) # Finish bill
      end
    end
  end

  def increase_sequence
    @@seq += 1
    @@seq = 32 if @@seq > 127
  end
  
  def send_package(code, parameters)
    port = SerialPort.open('/dev/ttyUSB0')
    port.baud = 9600
    port.stop_bits = 1
    port.data_bits = 8
    port.parity = 0

    separated_params = []
    
    if parameters.present?
      parameters.each do |e| # Add the 0x1c separator between elements
        separated_params << 0x1c
        if e.to_s.length == 1
          separated_params << e.ord
        elsif e.to_s.length > 1
          e.to_s.split(//).each { |l| separated_params << l.ord }
        end
      end
    end
    
    package = [0x02, @@seq, code, separated_params, 0x03]
    hex_sum = '%04x' % package.flatten!.inject(0) { |t, b| t + b.ord } # Calc Checksum

    hex_sum.bytes { |b| package << b } # Add Checksum

    package.each { |b| port.putc b } # Send to print
    sleep 2

    increase_sequence
  end

  def line_item_for_bill(li, type)
    price = (type == 'A' ? li.price / (1 + (li.product.iva / 100)) : li.price).to_f.round(2)
    iva = (li.product.iva * 100).to_i.to_s
    [
      li.product.name.first(26),
      (li.quantity * 1000).to_i,
      price, iva, 'M', '1', '0', '', '', '', ''
    ]
  end
end
