# frozen_string_literal: true

require 'faker'

FactoryBot.define do
  factory :category do
    name { Faker::Name.unique.name }

    trait :no_name do
      name { nil }
    end

    factory :category_without_name, traits: [:no_name]
  end
end
