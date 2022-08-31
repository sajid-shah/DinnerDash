# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Order, type: :model do
  describe 'Order Associations : A Order' do
    it { is_expected.to have_many(:order_items) }
    it { is_expected.to have_many(:items) }
    it { is_expected.to belong_to(:user).optional }
    it { is_expected.to belong_to(:restaurant) }
  end

  context 'when validating Order' do
    it { is_expected.to validate_presence_of(:status) }
  end

  context 'when Order is created' do
    it 'have valid data before saving.' do
      expect(build(:order).save).to be_truthy
    end

    it 'by default, :status should be processing' do
      expect(build(:order).status).to eq('processing')
    end

    it 'must not save without :status' do
      order = build(:order_without_status)
      order.valid?
      expect(order.valid?).to be(false)
    end

    it 'must have valid :total' do
      order = build(:order)
      expect(order.total).to be.>= (0)
    end
  end
end
