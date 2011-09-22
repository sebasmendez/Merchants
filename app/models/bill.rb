class Bill < ActiveRecord::Base
  
  #validates
  validates :barcode, :uniqueness => { :message => 'must be unique'}
  validates :barcode, :date, :amount, :items, :presence => {
    :message => 'must be present'
  }
  validates :amount, :barcode, :numericality => {:greater_than_or_equal_to => 0,
    :message => 'must be a number'
  }
  validates_date :date, :on => :create, :on_or_before => :today
  
  #relations
  belongs_to :client
  #helpers
  def initialize (attributes = nil, options = {})
    super(attributes, options)
    self.barcode ||= (Bill.order('barcode DESC').first.try(:barcode) || 0) + 1
  end
  
end
