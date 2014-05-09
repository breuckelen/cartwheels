class CreateMenus < ActiveRecord::Migration
    def change
        create_table :menus do |t|
            t.integer :cart_id

            t.timestamps
        end

        add_index :menus, :cart_id
    end
end
