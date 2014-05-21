class CreateUserCartRelations < ActiveRecord::Migration
    def change
        create_table :user_cart_relations do |t|
            t.integer :relation_type, precision: 1
            t.integer :user_id
            t.integer :cart_id
        end

        add_index :user_cart_relations, :user_id
        add_index :user_cart_relations, :cart_id
    end
end
