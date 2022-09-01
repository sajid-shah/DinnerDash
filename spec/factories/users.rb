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

    trait :customer do
      role { 'customer' }
    end

    trait :admin do
      role { 'admin' }
    end

    trait :superadmin do
      role { 'superadmin' }
    end

    factory :customer_user, traits: [:customer]
    factory :admin_user, traits: [:admin]
    factory :superadmin_user, traits: [:superadmin]

    factory :user_without_displayname, traits: [:no_displayname]
  end
end
