class CreateMenuItems < ActiveRecord::Migration
  def change
    create_table :menu_items do |t|
        t.text :description
        t.string :image_url
        t.float :price, precision: 6, scale: 2
        t.integer :menu_id
        t.timestamps
    end
  end
end
