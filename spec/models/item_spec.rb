# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'Item Associations : An Item' do
    it { is_expected.to have_many(:categorizations) }
    it { is_expected.to have_many(:order_items) }
    it { is_expected.to have_many(:categories) }
    it { is_expected.to have_many(:orders) }
    it { is_expected.to belong_to(:restaurant) }
    it { is_expected.to have_one_attached(:image) }
  end

  context 'when validating Item' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_uniqueness_of(:title) }
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_numericality_of(:price).is_greater_than(0) }
  end

  context 'when Item is created' do
    it 'have valid data before saving.' do
      expect(build(:item)).to be_valid
    end

    it 'must not save without :title' do
      item = build(:item_with_no_title)
      item.valid?
      expect(item.valid?).to be(false)
    end

    it 'must not save without :description' do
      item = build(:item_with_no_description)
      item.valid?
      expect(item.valid?).to be(false)
    end

    it 'by default, :active should be :true' do
      expect(build(:item).active).to be(true)
    end

    it 'can be set for :active false' do
      expect(build(:item_with_active_false).active).to be(false)
    end

    it 'must not save without :category_ids' do
      # Category.destroy_all
      expect(build(:item_without_category)).not_to be_valid
    end
  end
end
