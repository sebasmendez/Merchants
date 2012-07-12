class Client < ActiveRecord::Base
  
  find_by_autocomplete :name, limit: 4
  
  before_save :up_name, :down_bill
  after_save :plus_to_boxes, :add_deposit
 
  #validates
  validates :name, :last_name, :document, :presence => true
  
  validates :document, :uniqueness => true, 
              :numericality => true
  
  validates :amount, :to_amount, :spend, :phone, allow_nil: true,
              allow_blank: true, numericality: true
  
  has_many :bills
  has_many :orders
  has_many :payments
  
  scope :with_client, lambda { |search| where("LOWER(name) LIKE :q OR LOWER(last_name) LIKE :q OR document LIKE :q",
      q: "#{search}%".downcase)}
  
  attr_accessor :to_amount
  alias_method :label, :to_s
  #methods
  def to_s
    self.name + ' ' + self.last_name
  end
  
  def as_json(options= nil)
    default_options = {
      only: [:id],
      methods: [:label, :informal, :free_credit]
    }
    
    super(default_options.merge(options || {}))
  end
  
  def up_name
    self.name = self.name.split.map(&:camelize).join(' ')
    self.last_name = self.last_name.split.map(&:camelize).join(' ')
  end
  
  def self.search(search)
    if search
      where("LOWER(name) LIKE :q OR LOWER(last_name) LIKE :q OR document LIKE :q",
        q: "#{search}%".downcase)
    else
      scoped
    end
  end
  
  def down_bill
    self.client_kind = '-'
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
      Payment.create(client_id: self.id, deposit: self.to_amount)
    end
  end
end
