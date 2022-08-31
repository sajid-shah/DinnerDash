# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'User Association : A User' do
    it { is_expected.to have_many(:orders) }
    it { is_expected.to have_many(:restaurants) }
  end

  context 'when validating User' do
    it { is_expected.to validate_presence_of(:fullname) }
    it { is_expected.to validate_length_of(:displayname) }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:password) }
    it { is_expected.to validate_length_of(:password) }
  end

  context 'when User is created' do
    it 'have valid data before saving.' do
      expect(build(:user).save).to be_truthy
    end

    it 'for first time, role should be superadmin' do
      expect(build(:user).role).to eq('superadmin')
    end

    it 'second time, role should be customer' do
      create(:user).save
      expect(build(:user).role).to eq('customer')
    end

    it 'must be saved without display name' do
      expect(build(:user).save).to be_truthy
    end
  end
end
