class CreateCartTagRelations < ActiveRecord::Migration
    def change
        create_table :cart_tag_relations do |t|
            t.integer :cart_id
            t.string :cart_type
            t.integer :tag_id

            t.timestamps
        end

        add_index :cart_tag_relations, [:cart_id, :cart_type]
        add_index :cart_tag_relations, :tag_id
    end
end
