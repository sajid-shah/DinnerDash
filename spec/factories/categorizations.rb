# frozen_string_literal: true

require 'faker'

FactoryBot.define do
  factory :categorization do
    item { FactoryBot.create(:item) }
    category { FactoryBot.create(:category) }

    item_id { item.id }
    category_id { category.id }
  end
end
