class CreateMenuGhostsUsersJoinTable < ActiveRecord::Migration
    def change
        create_table :menu_ghosts_users do |t|
            t.integer :menu_ghost_id
            t.integer :user_id
        end

        add_index :menu_ghosts_users, :menu_ghost_id
        add_index :menu_ghosts_users, :user_id
    end
end
