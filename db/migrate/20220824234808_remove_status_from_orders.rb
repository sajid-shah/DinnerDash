# frozen_string_literal: true

class RemoveStatusFromOrders < ActiveRecord::Migration[5.2]
  def change
    remove_column :orders, :status, :integer
  end
end
