class AddDescriptionToCarts < ActiveRecord::Migration
  def up
      add_column :carts, :description, :text
  end

  def down
      remove_column :carts, :description
  end
end
