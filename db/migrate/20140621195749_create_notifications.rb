class CreateNotifications < ActiveRecord::Migration
    def change
        create_table :notifications do |t|
            t.integer :cart_id
            t.text :decription
            t.timestamps
        end
    end
end
