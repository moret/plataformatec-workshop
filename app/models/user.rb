class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  # Could be role specific such as:
  # attr_accessible :email, :admin, :as => :admin
  # To be used on the controller as:
  # User.new(@user, :as => :admin)
  # @user.update_attributes(:as => :admin)
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me

  validates_presence_of :name
end
