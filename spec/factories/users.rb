# frozen_string_literal: true

require 'faker'

FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    fullname { Faker::Name.unique.name }
    displayname { nil }
    password { Faker::Alphanumeric.alphanumeric(6..32) }

    trait :no_displayname do
      displayname { nil }
    end

    factory :customer_user, traits: [:customer]
    factory :user_without_displayname, traits: [:no_displayname]
  end
end
