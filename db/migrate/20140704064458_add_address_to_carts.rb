class AddAddressToCarts < ActiveRecord::Migration
  def change
    add_column :carts, :address, :string
  end
end
