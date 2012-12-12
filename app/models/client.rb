class Client < ActiveRecord::Base
  has_paper_trail
  
  CLIENT_KINDS = {
    iva_resp_insc: 'I',
    iva_resp_not_insc: 'R',
    not_resp: 'N',
    exempt_iva: 'E',
    resp_monot: 'M',
    final_consumer: 'F',
    not_categoriced: 'S',
    social_monot: 'T',
    small_event_contributor: 'C',
    social_small_event_contributor: 'V'
  }.with_indifferent_access.freeze

  # Callbacks
  before_save :up_name
  after_save :plus_to_boxes, :add_deposit
 
  # Validations
  validates :name, :last_name, :document, :address, :presence => true
  
  validates :document, :uniqueness => true, :numericality => true
  
  validates :amount, :to_amount, :spend, :phone, allow_nil: true,
              allow_blank: true, numericality: true
  
  has_many :bills
  has_many :orders
  has_many :payments
  
  scope :between, ->(start, finish) { where(
    "#{table_name}.created_at BETWEEN :s AND :f",
    s: start, f: finish
  )}
  scope :with_client, ->(search) { where(
    [
      "LOWER(#{Client.table_name}.name) LIKE :q",
      "LOWER(#{Client.table_name}.last_name) LIKE :q",
      "#{Client.table_name}.document LIKE :q",
      "LOWER(#{Client.table_name}.name) LIKE :n AND LOWER(#{Client.table_name}.last_name) LIKE :l"
    ].join(' OR '),
    q: "%#{search}%".downcase, n: "%#{search.split.first}%".downcase, 
    l: "%#{search.split.last}%".downcase
  ).limit(5) }
  
  attr_accessor :to_amount
  
  
  #methods
  def to_s
    self.name + ' ' + self.last_name
  end

  def for_bill
    to_s.first(40)
  end

  alias_method :label, :to_s
  
  def as_json(options= nil)
    default_options = {
      only: [:id, :document, :bill_kind, :uic_type, :uic, :client_kind],
      methods: [:label]
    }
    
    super(default_options.merge(options || {}))
  end
  
  def up_name
    self.name = self.name.split.map(&:camelize).join(' ')
    self.last_name = self.last_name.split.map(&:camelize).join(' ')
  end

  def cuit_cuil_for_bill
    self.match(/\-+/) ? self.delete('-') : self
  end
  
  def self.search(search)
    if search
      where("LOWER(name) LIKE :q OR LOWER(last_name) LIKE :q OR document LIKE :q",
        q: "#{search}%".downcase)
    else
      scoped
    end
  end
    
  def plus_to_boxes
    @to_amount = self.to_amount
    if @to_amount.present? && @to_amount.to_d > 0
      @daybox = Box.find_or_create_by_day_and_month_and_year(Date.today.day, Date.today.month, Date.today.year)
      @daybox.count = ((@daybox.count += 1) || 0)
      @daybox.total += @to_amount.to_d
      @daybox.update_attributes(total: @daybox.total, count: @daybox.count)
    end
  end

  def add_deposit
    if self.to_amount.present? && self.to_amount.to_d != 0
      debt = Client.find(self.id).amount
      Payment.create(
        client_id: self.id, deposit: self.to_amount, debt_rest: debt
      )
    end
  end

  def self.to_csv
    CSV.generate do |csv|
      csv << [
        'Nombre y apellido', 'Documento', 'Factura', 'Direccion',
        'Telefono', 'Tipo cliente', 'CuiX'
      ]
      scoped.each do |client|
        client_kind = I18n.t(
          "view.clients.client_kind.#{CLIENT_KINDS.invert[client.client_kind]}"
        )
        csv <<  [
          client, 
          client.document,
          client.bill_kind,
          [client.address, client.location].join(' - '),
          [client.phone, client.cellphone].join('---'),
          client_kind,
          [client.uic_type, client.uic].join(' ')
        ]
      end
    end 
  end
  
  def to_csv
    CSV.generate do |csv|
      csv << [
        'Nombre y apellido', 'Documento', 'Factura', 'Direccion',
        'Telefono', 'Tipo cliente', 'CuiX', 'Deuda'
      ]
      client = self
      client_kind = I18n.t(
        "view.clients.client_kind.#{CLIENT_KINDS.invert[client.client_kind]}"
      )
      csv <<  [
        client, 
        client.document,
        client.bill_kind,
        [client.address, client.location].join(' - '),
        [client.phone, client.cellphone].join('---'),
        client_kind,
        [client.uic_type, client.uic].join(' '),
        client.amount
      ]

      2.times { csv << [] }
      csv << [ 'Orden Nro', 'Fecha', 'Precio', 'Fiado?' ]
      client.orders.each do |order|
        csv << [
          order.id, I18n.l(order.created_at, format: :long),
          order.price, (order.to_amount ? 'SI' : 'NO')
        ]
      end

      csv << []
      csv << ['PAGOS']
      csv << ['Fecha','Cant pagada', 'Deuda']
      client.payments.each do |pay|
        csv << [I18n.l(pay.created_at), pay.deposit, pay.debt_rest]
      end
    end
  end
end
