class Product < ActiveRecord::Base
  #validates
  validates :barcode, :name, :price, :count, :presence => {
    :message => 'must be present'
  }
  validates :barcode, :uniqueness => {:message => 'must be unique'}
  validates :barcode, :price, :count, :numericality => {:message => 'must be number'}
end
