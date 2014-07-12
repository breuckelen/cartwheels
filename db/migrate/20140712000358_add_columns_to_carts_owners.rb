class AddColumnsToCartsOwners < ActiveRecord::Migration
  def change
      add_column :carts_owners, :cart_id, :integer
      add_column :carts_owners, :owner_id, :integer
  end
end
