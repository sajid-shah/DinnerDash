# frozen_string_literal: true

class Item < ApplicationRecord
  after_initialize :set_default_active, if: :new_record?
  has_many :categorizations, dependent: :destroy
  has_many :order_items, dependent: :destroy
  has_many :categories, through: :categorizations, dependent: :destroy
  has_many :orders, through: :order_items
  belongs_to :restaurant
  validates :price, numericality: { only_float: true, greater_than: 0 }
  validates :title, presence: true, uniqueness: true
  validates :description, presence: true
  validate :category_present?

  def category_present?
    if Category.all.count.zero?
      errors.add(:category, 'should be created first') if Category.all.count.zero?
    elsif category_ids.count.zero?
      errors.add(:category, 'is not selected')
    end
  end

  def set_default_active
    self.active = true
  end
end
