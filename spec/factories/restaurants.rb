# frozen_string_literal: true

require 'faker'

FactoryBot.define do
  factory :restaurant do
    name { Faker::Restaurant.unique.name }
    user { FactoryBot.create(:user) }
    user_id { user.id }

    trait :no_name do
      name { nil }
    end

    factory :restaurant_without_name, traits: [:no_name]
  end
end
