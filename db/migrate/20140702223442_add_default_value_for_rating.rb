class AddDefaultValueForRating < ActiveRecord::Migration
  def change
    change_column :carts, :rating, :float, scale: 3, precision: 2, null: true, default: nil
  end
end
