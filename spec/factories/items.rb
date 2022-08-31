# frozen_string_literal: true

require 'faker'

FactoryBot.define do
  factory :item do
    title { Faker::Food.unique.dish }
    description { Faker::Food.description }
    price { Faker::Number.between(0.0, 1000.0) }

    restaurant { FactoryBot.create(:restaurant) }

    category_ids do
      [
        FactoryBot.create(:category).id
        # FactoryBot.create(:category).id,
      ]
    end

    trait :no_title do
      title { nil }
    end

    # trait :no_category_selected do
    #   FactoryBot.create(:category)
    #   category_ids { [] }
    # end

    trait :no_category do
      category_ids { [] }
    end

    trait :no_description do
      description { nil }
    end

    trait :active_false do
      active { false }
    end

    factory :item_with_no_title, traits: [:no_title]
    factory :item_with_no_description, traits: [:no_description]
    factory :item_with_active_false, traits: [:active_false]
    factory :item_without_category, traits: [:no_category]
    # factory :item_without_category_created, traits: [:no_category_created]


  end
end
