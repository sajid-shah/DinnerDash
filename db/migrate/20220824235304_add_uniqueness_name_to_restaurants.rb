# frozen_string_literal: true

class AddUniquenessNameToRestaurants < ActiveRecord::Migration[5.2]
  def change
    add_index :restaurants, :name, unique: true
  end
end
