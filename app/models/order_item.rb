# frozen_string_literal: true

class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :item
  before_save :set_total
  validates :quantity, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :totalamount, presence: true, numericality: { only_float: true, greater_than: 0 }
  validates :unit_price, presence: true, numericality: { only_float: true, greater_than: 0 }



  before_save :set_unit_price

  def unit_price
    self[:unit_price]
  end

  def total
    unit_price * quantity
  end

  private

  def set_unit_price
    self[:unit_price] = unit_price
  end

  def set_total
    self[:totalamount] = total
  end
end
