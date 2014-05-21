class CreateClickthroughs < ActiveRecord::Migration
    def change
        create_table :clickthroughs do |t|
            t.integer :count, default: 0
            t.integer :user_id
            t.integer :cart_id

            t.timestamps
        end

        add_index :clickthroughs, :user_id
        add_index :clickthroughs, :cart_id
    end
end
