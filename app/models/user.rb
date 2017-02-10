class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, 
         :confirmable, :lockable,
         :trackable, :validatable
end
