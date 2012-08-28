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
      @monthly = Monthly.find_or_create_by_month_and_year(Date.today.month, Date.today.year)
      @monthly.sold ||= 0
      @monthly.sold += @to_amount.to_d
      @monthly.update_attributes(sold: @monthly.sold)
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
end
