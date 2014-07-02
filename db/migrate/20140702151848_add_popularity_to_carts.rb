class AddPopularityToCarts < ActiveRecord::Migration
  def change
      add_column :carts, :popularity, :integer, scale: 8, precision: 2, default: 0
  end
end
