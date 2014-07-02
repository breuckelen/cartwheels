class AllowNullForRating < ActiveRecord::Migration
  def change
    change_column :carts, :rating, :float, scale: 3, precision: 2, null: true
  end
end
