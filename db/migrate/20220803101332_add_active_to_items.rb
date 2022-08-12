# frozen_string_literal: true

class AddActiveToItems < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :active, :bool
  end
end
