class Client < ActiveRecord::Base
  before_save :up_name, :down_bill
  after_save :plus_to_boxes
 
  #validates
  validates :name, :last_name, :document, :presence => {
    :message => 'must be present'  }
  
  validates :document, :uniqueness => { :message => 'must be unique'}, 
    :numericality => { :message => 'must be number' }
  
  validates :amount, :to_amount, :spend, :phone, allow_nil: true, allow_blank: true, numericality: true
  
  has_many :bills
  has_many :orders
  
  scope :with_client, lambda { |search| where("LOWER(name) LIKE ? OR LOWER(last_name) LIKE ? OR document LIKE ?",
      "#{search}%".downcase, "#{search}%".downcase, "#{search}%")}
  
  attr_accessor :to_amount
  
  #methods
  def to_s
    self.name + ' ' + self.last_name + ' ' + self.document
  end
  
  def up_name
    self.name = self.name.split.map(&:camelize).join(' ')
    self.last_name = self.last_name.split.map(&:camelize).join(' ')
  end
  
  def self.search(search)
    if search
      where("LOWER(name) LIKE ? OR LOWER(last_name) LIKE ? OR document LIKE ?",
        "#{search}%".downcase, "#{search}%".downcase, "#{search}%")
    else
      scoped
    end
  end
  
  def down_bill
    self.client_kind = '-'
  end
  def plus_to_boxes
    @to_amount = self.to_amount
    if @to_amount.present?
      @daybox = Box.find_or_create_by_day_and_month_and_year(Date.today.day, Date.today.month, Date.today.year)
      @daybox.count = ((@daybox.count += 1) || 0)
      @daybox.total += @to_amount.to_d
      @daybox.update_attributes(total: @daybox.total, count: @daybox.count)
      if @to_amount.to_d > 0
      @monthly = Monthly.find_or_create_by_month_and_year(Date.today.month, Date.today.year)
      @monthly.sold ||= 0
      @monthly.sold += @to_amount.to_d
      @monthly.update_attributes(sold: @monthly.sold)
      end
    end
  end
end
