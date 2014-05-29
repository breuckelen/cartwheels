class CreateBadges < ActiveRecord::Migration
    def up
        create_table :badges do |t|
            t.string :title, :default => ""
        end
    end

    def down
        drop_table :badges
    end
end
