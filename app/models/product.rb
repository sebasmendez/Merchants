class Product < ActiveRecord::Base
  
  
  #before_destroy :not_referenced
  before_save :up_product
  #validates
  has_many :line_items
  has_many :orders, through: :line_items
  belongs_to :category
  
  validates :barcode, :name, :count, :price, :presence => true
  validates :barcode, :uniqueness => true
  validates :barcode, :count, :numericality => true
  
  attr_accessor :earn, :newstock
  
  #helpers
  
  def initialize (attributes = nil, options = {})
    super(attributes, options)
    self.barcode ||= (Product.order('barcode DESC').first.try(:barcode) || 0) + 1
  end
  
  #default_scope :order => 'name'

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
      where("LOWER(name) LIKE :q OR LOWER(mark) LIKE :q OR barcode LIKE :q OR LOWER(fragance) LIKE :q OR category_id LIKE :t",
        q: "#{search}%".downcase, t: Category.where("LOWER(categoria) LIKE :c", c: "#{search}%".downcase).first )
    else
      scoped
    end
  end
  
  
end
