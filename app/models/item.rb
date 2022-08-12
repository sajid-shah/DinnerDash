# frozen_string_literal: true

class Item < ApplicationRecord
  after_initialize :set_default_active, if: :new_record?
  has_many :categorizations, dependent: :destroy
  has_many :order_items, dependent: :destroy
  has_many :categories, through: :categorizations, dependent: :destroy
  has_many :orders, through: :order_items
  def set_default_active
    self.active = true
  end
end
