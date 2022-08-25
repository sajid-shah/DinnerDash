# frozen_string_literal: true

class AddNameToCategories < ActiveRecord::Migration[5.2]
  def change
    add_column :categories, :name, :string, unique: true, null: false, default: ''
  end
end
