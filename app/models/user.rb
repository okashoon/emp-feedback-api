class User < ActiveRecord::Base
  # Include default devise modules.
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable, password_length: 2..30
  include DeviseTokenAuth::Concerns::User
end
