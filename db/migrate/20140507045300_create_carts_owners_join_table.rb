class CreateCartsOwnersJoinTable < ActiveRecord::Migration
    def change
        create_table :carts_owners do |t|
            t.integer :cart_id
            t.integer :owner_id
        end

        add_index :carts_owners, :cart_id
        add_index :carts_owners, :owner_id
    end
end
