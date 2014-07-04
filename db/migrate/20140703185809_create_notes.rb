class CreateNotes < ActiveRecord::Migration
    def up
        create_table :notes do |t|
            t.integer :user_id
            t.integer :menu_item_id
            t.string :text

            t.timestamps
        end
    end

    def down
        drop_table :notes
    end
end
