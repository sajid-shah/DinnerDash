# frozen_string_literal: true

class AddActiveStatusToItems < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :active, :bool, null: false, default: true
  end
end
