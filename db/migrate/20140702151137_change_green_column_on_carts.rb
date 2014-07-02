class ChangeGreenColumnOnCarts < ActiveRecord::Migration
  def change
      change_column :carts, :green, :integer, scale: 1, default: 0
  end
end
