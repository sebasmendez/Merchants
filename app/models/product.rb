class Product < ActiveRecord::Base
  #validates
  validates :barcode, :name, :price, :count, :presence => {
    :message => 'must be present'
  }
  validates :barcode, :uniqueness => {:message => 'must be unique'}
  validates :barcode, :price, :count, :numericality => {:message => 'must be number'}
  
  #helpers
  
  def initialize (attributes = nil, options = {})
    super(attributes, options)
    self.barcode ||= (Product.order('barcode DESC').first.try(:barcode) || 0) + 1
  end
  
end
