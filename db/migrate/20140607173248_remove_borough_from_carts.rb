class RemoveBoroughFromCarts < ActiveRecord::Migration
  def up
      remove_column :carts, :borough
  end

  def down
      add_column :carts, :borough, :string
  end
end
