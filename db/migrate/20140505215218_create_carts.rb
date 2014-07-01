class CreateCarts < ActiveRecord::Migration
  def change
    create_table :carts do |t|
        t.string :name
        t.string :city
        t.string :borough
        t.integer :upload_id
        t.integer :owner_secret, precision: 10
        t.integer :permit_number
        t.integer :zip_code
        t.float :lat, precision: 10, scale: 7
        t.float :lon, precision: 10, scale: 7

        t.timestamps
    end

    add_index :carts, :permit_number
    add_index :carts, [:created_at, :name]
  end
end
