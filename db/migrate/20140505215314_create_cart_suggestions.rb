class CreateCartSuggestions < ActiveRecord::Migration
  def change
    create_table :cart_suggestions do |t|
        t.string :name
        t.string :city
        t.string :borough
        t.integer :permit_number
        t.integer :zip_code
        t.float :lat, precision: 8, scale: 5
        t.float :lon, precision: 8, scale: 5
        t.boolean :approved, :default => false
        t.timestamps
    end
  end
end
