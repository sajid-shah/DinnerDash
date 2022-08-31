# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Restaurant, type: :model do
  describe 'Restaurant Associations : A Restaurant' do
    it { is_expected.to have_many(:orders) }
    it { is_expected.to have_many(:items) }
    it { is_expected.to belong_to(:user) }
  end

  context 'when validating Restaurant' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:name) }
  end

  context 'when Restaurant is created' do
    it 'have valid data before saving.' do
      expect(build(:restaurant).save).to be_truthy
    end

    it 'must not save without name' do
      restaurant = build(:restaurant_without_name)
      restaurant.valid?
      expect(restaurant.valid?).to be(false)
    end
  end
end
