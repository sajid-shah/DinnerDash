# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Categorization, type: :model do
  describe 'Categorization Associations : A Categorization' do
    it { is_expected.to belong_to(:category) }
    it { is_expected.to belong_to(:item) }
  end
end
