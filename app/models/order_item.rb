# frozen_string_literal: true

class OrderItem < ApplicationRecord
  belongs_to :user
  belongs_to :item
end
