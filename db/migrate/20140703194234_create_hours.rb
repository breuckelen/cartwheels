class CreateHours < ActiveRecord::Migration
    def up
        create_table :hours do |t|
            t.integer :cart_id
            t.integer :day
            t.integer :start
            t.integer :end

            t.timestamps
        end
    end

    def down
        drop_table :hours
    end
end
