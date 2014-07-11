class RenameCartsOwners < ActiveRecord::Migration
  def change
      rename_table :carts_owners, :cart_owner_relations
  end
end
