class RenameGreenColumn < ActiveRecord::Migration
  def change
      rename_column :carts, :green?, :green
  end
end
