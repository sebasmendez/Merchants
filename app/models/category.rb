class Category < ActiveRecord::Base
  
  has_many :products
  
  
  def to_s
    self.categoria
  end
end
