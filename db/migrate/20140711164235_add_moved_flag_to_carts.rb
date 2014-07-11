class AddMovedFlagToCarts < ActiveRecord::Migration
    def change
        add_column :carts, :moved, :boolean, default: false
    end
end
