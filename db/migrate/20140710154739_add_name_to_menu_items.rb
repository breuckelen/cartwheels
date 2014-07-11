class AddNameToMenuItems < ActiveRecord::Migration
  def change
      remove_column :menu_items, :image_url
  end
end
