class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable#, :confirmable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  # attr_accessible :title, :body
  
  has_many :locations
  has_many :ufiles
  has_many :invitations, :class_name => 'User', :as => :invited_by
  
  def sign_up_at
    !invitation_accepted_at.blank? && invitation_accepted_at > created_at ? invitation_accepted_at : created_at
  end
  
  def user_ids_in_network
    [id, invited_by_id] + invitation_ids
  end
end
