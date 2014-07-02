class AddDefaultForGreen < ActiveRecord::Migration
  def change
      change_column :carts, :green, :boolean, default: false
  end
end
