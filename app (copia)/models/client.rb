class Client < ActiveRecord::Base
  before_save :up_name
  #validates
  validates :name, :last_name, :document, :client_kind, :presence => {
    :message => 'must be present'
  }
  validates :document, :uniqueness => { :message => 'must be unique'}, 
    :numericality => { :message => 'must be number'}
  
  has_many :bills
  
  #methods
  def to_s
    self.name + ' ' + self.last_name
  end
  
  def up_name
    self.name = self.name.split.map(&:camelize).join(' ')
    self.last_name = self.last_name.split.map(&:camelize).join(' ')
  end
  
end
