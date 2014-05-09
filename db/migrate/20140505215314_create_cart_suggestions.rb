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

    add_index :cart_suggestions, :permit_number
    add_index :cart_suggestions, [:created_at, :name]
    add_index :cart_suggestions, [:created_at, :city]
    add_index :cart_suggestions, [:created_at, :borough]
    add_index :cart_suggestions, [:created_at, :permit_number]
    add_index :cart_suggestions, [:created_at, :zip_code]
  end
end
