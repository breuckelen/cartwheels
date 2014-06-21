class RemoveCartGhostsAndMenuGhosts < ActiveRecord::Migration
    def change
        drop_table :cart_ghosts
        drop_table :menu_ghosts
        drop_table :cart_ghosts_users
        drop_table :menu_ghosts_users
    end
end
