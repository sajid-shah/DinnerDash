# frozen_string_literal: true

class Order < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :restaurant
  has_many :order_items, dependent: :destroy
  has_many :items, through: :order_items
  after_initialize :set_default_status, if: :new_record?
  validates :status, presence: true
  enum status: { processing: 0, ordered: 1, paid: 2, cancelled: 3, completed: 4 }

  def set_default_status
    self[:status] = :processing
  end
end
