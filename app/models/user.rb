class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  
  #Used for devise. Looks like it sets various paramaters for the plugin
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  #sets up relationship with orders
  has_many :orders
end