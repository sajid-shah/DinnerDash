# frozen_string_literal: true

class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items, dependent: :destroy
  has_many :items, through: :order_items
  enum status: { processing: 0, ordered: 1, paid: 2, completed: 3 }
  after_initialize :set_default_status, if: :new_record?
  def set_default_status
    self.status ||= :processing
  end
end
