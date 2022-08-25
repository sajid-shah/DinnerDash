# frozen_string_literal: true

class RemoveDescriptionFromItem < ActiveRecord::Migration[5.2]
  def change
    remove_column :items, :description, :string
  end
end
