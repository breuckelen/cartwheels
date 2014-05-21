class CreateCartGhostsUsersJoinTable < ActiveRecord::Migration
    def change
        create_table :cart_ghosts_users do |t|
            t.integer :cart_ghost_id
            t.integer :user_id
        end

        add_index :cart_ghosts_users, :cart_ghost_id
        add_index :cart_ghosts_users, :user_id
    end
end
