class AddDescriptionToCartGhosts < ActiveRecord::Migration
  def up
      add_column :cart_ghosts, :description, :text
  end

  def down
      remove_column :cart_ghosts, :description
  end
end
