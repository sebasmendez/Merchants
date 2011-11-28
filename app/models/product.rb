class Product < ActiveRecord::Base
  #before_destroy :not_referenced
  before_save :up_product
  #validates
  has_many :line_items
  has_many :orders, through: :line_items
  
  validates :barcode, :name, :count, :presence => true
  validates :barcode, :uniqueness => true
  validates :barcode, :count, :numericality => true
  
  attr_accessor :earn, :newstock
  
  #helpers
  
  def initialize (attributes = nil, options = {})
    super(attributes, options)
    self.barcode ||= (Product.order('barcode DESC').first.try(:barcode) || 0) + 1
  end
  
  default_scope :order => 'name'

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
    if search
      where('LOWER(name) || LOWER(mark) || barcode || LOWER(category) LIKE ?', "%#{search}%".downcase)
    else
      scoped
    end
  end
  
  
end
