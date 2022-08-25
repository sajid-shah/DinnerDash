# frozen_string_literal: true

class AddNameToRestaurants < ActiveRecord::Migration[5.2]
  def change
    add_column :restaurants, :name, :string, null: false, default: '', unique: true
  end
end
