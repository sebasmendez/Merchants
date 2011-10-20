class Product < ActiveRecord::Base
  before_destroy :not_referenced
  #validates
  has_many :line_items
  has_many :orders
  
  validates :barcode, :name, :price, :count, :presence => true
  validates :barcode, :uniqueness => true
  validates :barcode, :price, :count, :numericality => true
  
  #helpers
  
  def initialize (attributes = nil, options = {})
    super(attributes, options)
    self.barcode ||= (Product.order('barcode DESC').first.try(:barcode) || 0) + 1
  end
  
  default_scope :order => 'name'

  def not_referenced
    if line_items.emply?
      return true
    else
      error.add(:base, 'Line Item Present')
      return false
    end
  end
  
  
end
