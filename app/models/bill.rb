class Bill < ActiveRecord::Base
   after_save :plus_amount_to_monthly, :plus_to_client_spend
  
  #validates
  
  validates :barcode, :uniqueness => true
  validates :barcode, :date, :amount, :items, :presence => true
  
  validates :amount, :barcode, :numericality => {:greater_than => 0 }
  validates_date :date, :on => :create, :on => :today
  
  #relations
  belongs_to :client
  
  #Methods
  
  
  def initialize (attributes = nil, options = {})
    super(attributes, options)
    self.barcode ||= (Bill.order('barcode DESC').first.try(:barcode) || 0) + 1
  end
  
  def plus_amount_to_monthly
    
    @bill = Bill.order('id DESC').first
    @monthly = Monthly.find_or_create_by_month_and_year(@bill.date.month, @bill.date.year)
    @monthly.sold ||= 0
    @monthly.sold += @bill.amount
    @monthly.update_attributes(sold: @monthly.sold)
  end
  
  def plus_to_client_spend
    @bill = Bill.order('id DESC').first
    if @bill.client_id
    @client = Client.find(@bill.client_id) 
    @client.spend += @bill.amount
    @client.update_attributes(spend: @client.spend)
    end
  end
  
end
