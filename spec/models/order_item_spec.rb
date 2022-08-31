# frozen_string_literal: true

require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  describe 'OrderItem Associations : An OrderItem' do
    it { is_expected.to belong_to(:item) }
    it { is_expected.to belong_to(:order) }
  end

  context 'when validating OrderItem' do
    it { is_expected.to validate_presence_of(:quantity) }
    it { is_expected.to validate_presence_of(:totalamount) }
    it { is_expected.to validate_presence_of(:unit_price) }
    it { is_expected.to validate_numericality_of(:quantity).is_greater_than(0) }
    it { is_expected.to validate_numericality_of(:unit_price).is_greater_than(0) }
    it { is_expected.to validate_numericality_of(:totalamount).is_greater_than(0) }
  end

  context 'when OrderItem is created' do
    it 'have valid data before saving.' do
      expect(build(:order_item).save).to be_truthy
    end
  end
end
