class AddDescriptionToCheckin < ActiveRecord::Migration
  def change
    add_column :checkins, :description, :text, default: ''
  end
end
