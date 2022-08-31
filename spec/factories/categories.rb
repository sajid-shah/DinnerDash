# frozen_string_literal: true

require 'faker'

FactoryBot.define do
  factory :category do
    Faker::Food.unique.clear

    name { Faker::Food.unique.spice }

    trait :no_name do
      name { nil }
    end

    factory :category_without_name, traits: [:no_name]
  end
end
