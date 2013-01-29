class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :username, :password, :password_confirmation,
    :remember_me
  # attr_accessible :title, :body

  validates :email, :username, :password, :password_confirmation,
    presence: true
  validates :email, :username, uniqueness: true

  def to_s
    self.username
  end
end
