# frozen_string_literal: true

class RemoveFullnameFromUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :fullname, :string
  end
end
