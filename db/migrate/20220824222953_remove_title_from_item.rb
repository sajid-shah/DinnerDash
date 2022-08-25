# frozen_string_literal: true

class RemoveTitleFromItem < ActiveRecord::Migration[5.2]
  def change
    remove_column :items, :title, :string
  end
end
