class CreateCartSuggestions < ActiveRecord::Migration
  def change
    create_table :cart_suggestions do |t|
        t.string :name
        t.string :city
        t.string :borough
        t.integer :permit_number
        t.integer :zip_code
        t.integer :lat, precision: 8, scale: 5
        t.integer :lon, precision: 8, scale: 5
        t.boolean :approved
        t.timestamps
    end
  end
end
