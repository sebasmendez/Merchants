class Client < ActiveRecord::Base
  #validates
  validates :name, :last_name, :document, :client_kind, :presence => {
    :message => 'must be present'
  }
  validates :document, :uniqueness => { :message => 'must be unique'}, 
    :numericality => { :message => 'must be number'}
  
  has_many :bills
  
  def to_s
    self.name + ' ' + self.last_name
  end
  
  
end
