class CreateCarts < ActiveRecord::Migration
  def change
    create_table :carts do |t|
        t.string :name
        t.string :city
        t.string :borough
        t.integer :owner_secret, precision: 10
        t.integer :permit_number
        t.integer :zip_code
        t.integer :lat, precision: 8, scale: 5
        t.integer :lon, precision: 8, scale: 5
        t.timestamps
    end
  end
end
