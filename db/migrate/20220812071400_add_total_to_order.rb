# frozen_string_literal: true

class AddTotalToOrder < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :total, :decimal
  end
end
