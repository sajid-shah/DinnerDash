class RemoveTotalFromOrder < ActiveRecord::Migration[5.2]
  def change
    remove_column :orders, :total, :integer
  end
end
