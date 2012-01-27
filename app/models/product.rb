class Product < ActiveRecord::Base
  
  
  before_destroy :not_referenced
  before_save :up_product

  
  #validates
  has_many :line_items
  has_many :orders, through: :line_items
  belongs_to :category
  
  validates :barcode, :name, :count, :price, :presence => true
  validates :barcode, :uniqueness => true
  validates :count, :numericality => true
  
  attr_accessor :earn, :newstock
  
  #helpers
  
  def initialize (attributes = nil, options = {})
    super(attributes, options)
    self.barcode ||= (Product.order('barcode DESC').first.try(:barcode) || 0).to_i + 1
  end
  
 
  
  def not_referenced
    if line_items.empty?
      return true
    else
      error.add(:base, 'Line Item Present')
      return false
    end
  end
  
  def up_product
    self.name = self.name.split.map(&:camelize).join(' ')
    self.mark = self.mark.split.map(&:camelize).join(' ')
    self.fragance = self.fragance.split.map(&:camelize).join(' ')
  end
  
  def self.search(search)
    if search.present? # Mucho mejor, si search es " " (un espacio), da true, de esta forma no =)
      includes(:category).where(
        [
          "LOWER(#{table_name}.name) LIKE :q",
          "LOWER(#{table_name}.mark) LIKE :q",
          "#{table_name}.barcode LIKE :q",
          "LOWER(#{table_name}.fragance) LIKE :q",
          "LOWER(#{Category.table_name}.categoria) LIKE :q"
        ].join(' OR '),
        q: "#{search}%".downcase
      )
    else
      scoped
    end
  end
  
  
end
