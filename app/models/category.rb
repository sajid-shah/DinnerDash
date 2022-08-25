# frozen_string_literal: true

class Category < ApplicationRecord
  has_many :categorizations, dependent: :destroy
  has_many :items, through: :categorizations, dependent: :destroy
  validates :name, presence: true, uniqueness: true
end
