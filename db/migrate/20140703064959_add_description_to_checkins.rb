class AddDescriptionToCheckins < ActiveRecord::Migration
  def change
    remove_column :checkins, :description
    add_column :checkins, :description, :text
  end
end
