class Restaurant < ApplicationRecord
  has_many :items, dependent: :destroy
  has_many :orders, dependent: :destroy
  belongs_to :user
end
