# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Category, type: :model do
  describe 'Category Associations : A Category' do
    it { is_expected.to have_many(:items) }
    it { is_expected.to have_many(:categorizations) }
  end

  context 'when validating Category' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:name) }
  end

  context 'when Category is created' do
    it 'have valid data before saving.' do
      expect(build(:category).save).to be_truthy
    end

    it 'must not save without name' do
      category = build(:category_without_name)
      category.valid?
      expect(category.valid?).to be(false)
    end
  end
end
