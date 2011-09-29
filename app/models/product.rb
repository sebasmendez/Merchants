class Product < ActiveRecord::Base
  #validates
  validates :barcode, :name, :price, :count, :presence => true
  validates :barcode, :uniqueness => true
  validates :barcode, :price, :count, :numericality => true
  
  #helpers
  
  def initialize (attributes = nil, options = {})
    super(attributes, options)
    self.barcode ||= (Product.order('barcode DESC').first.try(:barcode) || 0) + 1
  end
  
  #default_scope :order => 'title'

  
end
