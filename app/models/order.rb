# frozen_string_literal: true

class Order < ApplicationRecord
  belongs_to :user, optional: true
  has_many :order_items, dependent: :destroy
  has_many :items, through: :order_items
  after_initialize :set_default_status, if: :new_record?
  # before_save :set_total
  enum status: { processing: 0, ordered: 1, paid: 2, cancelled: 3, completed: 4 }

  def set_default_status
    self[:status] = :processing
    # self[:total] = Order.order_items.sum { |order_item| order_item.valid ? order_item.quantity * order_item.unit_price : 0 }
  end



end
