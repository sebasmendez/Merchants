class Category < ActiveRecord::Base
  
  has_many :products
  
  validates :categoria, presence: true, uniqueness: true
  
  def to_s
    self.categoria
  end
  
end
