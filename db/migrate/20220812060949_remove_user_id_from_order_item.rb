# frozen_string_literal: true

class RemoveUserIdFromOrderItem < ActiveRecord::Migration[5.2]
  def change
    remove_column :order_items, :user_id, :string
  end
end
