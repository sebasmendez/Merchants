class Order < ActiveRecord::Base
  has_many :line_items, dependent: :destroy
  belongs_to :client
  accepts_nested_attributes_for :line_items, :allow_destroy => true
  before_save :total_price
  after_save :plus_amount_to_monthly, :plus_to_client_spend, :discount_stock
  attr_accessor :auto_client
  before_validation :assign_client
  
  def assign_client
    if self.auto_client.present?
      self.document = Client.find_by_document(self.auto_client)
    end
  end
  
  def add_line_items_from_cart(cart)
    cart.line_items.each do |item|
      line_items.build(item.attributes.merge(id: nil))
    end
  end
  
  def total_price
    self.price = self.line_items.to_a.sum { |item| item.total_price}
  end
  
  def plus_amount_to_monthly
    @order = Order.order('id DESC').first
    @monthly = Monthly.find_or_create_by_month_and_year(@order.created_at.month, @order.created_at.year)
    @monthly.sold ||= 0
    @monthly.sold += @order.price
    @monthly.update_attributes(sold: @monthly.sold)
  end
  
  def plus_to_client_spend
    @order = Order.order('id DESC').first
    if @order.document
    @client = Client.find_by_document(@order.document) 
    @client.spend += @order.price
    @client.update_attributes(spend: @client.spend)
    end
  end
  
  def discount_stock
    @order = Order.order('id DESC').first
    @order.line_items.each do |li|
      @product = Product.find_by_id(li.product.id)
      @product.stock -= li.quantity
      @product.update_attributes(stock: @product.stock)
    end
  end
  
end
