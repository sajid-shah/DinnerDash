# frozen_string_literal: true

class RemoveNameFromCategories < ActiveRecord::Migration[5.2]
  def change
    remove_column :categories, :name, :string
  end
end
