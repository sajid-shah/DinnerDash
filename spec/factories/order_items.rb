# frozen_string_literal: true

require 'faker'

FactoryBot.define do
  factory :order_item do
    quantity { Faker::Number.between(1, 10) }
    unit_price { Faker::Number.between(1.0, 1000.0) }
    totalamount { Faker::Number.between(1.0, 1000.0) }

    order { FactoryBot.create(:order) }
    item { FactoryBot.create(:item) }
  end
end
