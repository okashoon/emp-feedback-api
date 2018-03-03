class Field < ApplicationRecord
    has_many :users_fields
    has_many :users, through: :users_fields, :source => :user
end
