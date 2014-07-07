class AddAnotherDescriptionToCarts < ActiveRecord::Migration
  def up
      add_column :carts, :description, :string, default: ''
  end

  def down
      remove_column :carts, :description
  end
end
