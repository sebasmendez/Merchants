class Bill < ActiveRecord::Base
   after_save :plus_amount_to_monthly
  
  #validates
  
  validates :barcode, :uniqueness => true
  validates :barcode, :date, :amount, :items, :presence => true
  
  validates :amount, :barcode, :numericality => {:greater_than_or_equal_to => 0 }
  validates_date :date, :on => :create, :on_or_before => :today
  
  #relations
  
  belongs_to :client
  
  #Methods
  
  
  def initialize (attributes = nil, options = {})
    super(attributes, options)
    self.barcode ||= (Bill.order('barcode DESC').first.try(:barcode) || 0) + 1
  end
  
  def plus_amount_to_monthly
    
    @month = (Monthly.order('id DESC').first) || 0
    (Monthly.create(month: Time.now.month, year: Time.now.year)) if @month == 0
    @monthly = Monthly.find_by_id(@month.id)
    @bill = Bill.order('id DESC').first
    
    if Time.now.month == @month.month
        if Time.now.year == @month.year
         @month.sold ||= 0
         @month.sold += @bill.amount
         @monthly.update_attributes(sold: @month.sold)
        else
         Monthly.create(month: Time.now.month, year: Time.now.year)
         plus_amount_to_monthly #recursion
        end
    end
  end
end
