class CreateMenuGhosts < ActiveRecord::Migration
  def change
    create_table :menu_ghosts do |t|
        t.text :description
        t.string :image_url
        t.float :price, precision: 6, scale: 2
        t.integer :menu_id
        t.boolean :approved, default: false

        t.timestamps
    end

    add_index :menu_ghosts, :menu_id
  end
end
