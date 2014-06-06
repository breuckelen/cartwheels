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
        t.integer :lat, precision: 8, scale: 5
        t.integer :lon, precision: 8, scale: 5

        t.timestamps
    end

    add_index :carts, :permit_number
    add_index :carts, [:created_at, :name]
    add_index :carts, [:created_at, :city]
    add_index :carts, [:created_at, :borough]
    add_index :carts, [:created_at, :permit_number]
    add_index :carts, [:created_at, :zip_code]
  end
end
