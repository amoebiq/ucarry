class User < ActiveRecord::Base

  has_many :carrier_schedule , foreign_key: 'carrier_id' , :primary_key => 'uid'
  has_many :sender_order , foreign_key: 'sender_id' , :primary_key => 'uid'
  has_many :ratings , :foreign_key => 'user' , :primary_key => 'uid'

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

 # attr_accessible :name, :email, :password, :password_confirmation, :remember_me


  # devise :database_authenticatable, :registerable,
  #        :recoverable, :rememberable, :trackable, :validatable  ,:confirmable ,:token_authenticatable
  # # Include default devise modules.
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable,
          :confirmable, :omniauthable
  include DeviseTokenAuth::Concerns::User
  #
  before_save -> { skip_confirmation! }


  #before_save :ensure_authentication_token




  def skip_confirmation!
    self.confirmed_at = Time.now
  end





end
