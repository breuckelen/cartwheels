class AddFieldsToCarts < ActiveRecord::Migration
  def change
    add_column :carts, :green?, :boolean
  end
end
