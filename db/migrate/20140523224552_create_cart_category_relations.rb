class CreateCartCategoryRelations < ActiveRecord::Migration
    def change
        create_table :cart_category_relations do |t|
            t.integer :cart_id
            t.string :cart_type
            t.integer :category_id

            t.timestamps
        end
    end
end
