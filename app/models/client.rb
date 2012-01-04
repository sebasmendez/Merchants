class Client < ActiveRecord::Base
  before_save :up_name, :down_bill
 
  #validates
  validates :name, :last_name, :document, :presence => {
    :message => 'must be present'
  }
  validates :document, :uniqueness => { :message => 'must be unique'}, 
    :numericality => { :message => 'must be number'}
  
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
  
end
