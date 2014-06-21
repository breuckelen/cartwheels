class AddIndexToCartLatAndLon < ActiveRecord::Migration
  def up
      add_index :carts, [:lat, :lon]
  end

  def down
      remove_index :carts, [:lat, :lon]
  end
end
