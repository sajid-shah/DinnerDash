# frozen_string_literal: true

class RemovesActiveFromItems < ActiveRecord::Migration[5.2]
  def change
    remove_column :items, :active, :boolean
  end
end
