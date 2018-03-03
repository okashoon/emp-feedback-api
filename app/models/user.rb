class User < ActiveRecord::Base
  # Include default devise modules.
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable, password_length: 2..30
  include DeviseTokenAuth::Concerns::User

  has_many :users_fields
  has_many :fields, through: :users_fields, :source => :field
  has_many :users_roles
  has_many :roles, through: :users_roles, :source => :role
end
