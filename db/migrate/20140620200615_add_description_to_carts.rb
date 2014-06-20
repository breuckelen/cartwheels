class AddDescriptionToCarts < ActiveRecord::Migration
  def up
      add_column :carts, :description, :text
      add_index :carts, [:created_at, :description]
  end

  def down
      remove_column :carts, :description
  end
end
