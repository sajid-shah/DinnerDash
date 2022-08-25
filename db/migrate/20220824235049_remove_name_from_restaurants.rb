# frozen_string_literal: true

class RemoveNameFromRestaurants < ActiveRecord::Migration[5.2]
  def change
    remove_column :restaurants, :name, :string
  end
end
