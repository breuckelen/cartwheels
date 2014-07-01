class AddMoreDecimalPlaces < ActiveRecord::Migration
  def change
    change_column :carts, :lat, :float, precision: 10, scale: 7
    change_column :carts, :lon, :float, precision: 10, scale: 7
    change_column :menu_items, :price, :float, precision: 7, scale: 3
    change_column :ad_types, :price, :float, precision: 7, scale: 3
  end
end
