class AddRatingToCarts < ActiveRecord::Migration
  def change
    add_column :carts, :rating, :float, scale: 3, precision: 2
  end
end
