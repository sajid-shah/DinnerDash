# frozen_string_literal: true

class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :item
  before_save :set_total
  before_save :set_unit_price

  def unit_price
    if persisted?
      self[:unit_price]
    else
      item.price
    end
  end

  def total
    return unit_price * quantity
  end

  private

  def set_unit_price
    self[:unit_price] = unit_price
  end

  def set_total
    self[:totalamount] = total
  end

end



