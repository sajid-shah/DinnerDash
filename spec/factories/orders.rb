# frozen_string_literal: true

require 'faker'
FactoryBot.define do
  factory :order do
    total { Faker::Number.between(0.0, 10_000.0) }

    restaurant { FactoryBot.create(:restaurant) }

    trait :no_status do
      status { nil }
    end

    factory :order_without_status, traits: [:no_status]
  end
end
