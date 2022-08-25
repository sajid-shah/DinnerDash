# frozen_string_literal: true

class AddTitleToItem < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :title, :string, null: false, unique: true, default: ''
  end
end
