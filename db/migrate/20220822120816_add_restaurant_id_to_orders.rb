# frozen_string_literal: true

class AddRestaurantIdToOrders < ActiveRecord::Migration[5.2]
  def change
    add_reference :orders, :restaurant, foreign_key: true
  end
end
