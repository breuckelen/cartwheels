class CreateCheckins < ActiveRecord::Migration
  def change
    create_table :checkins do |t|
      t.integer :user_id
      t.integer :cart_id

      t.float :lat, precision: 10, scale: 7
      t.float :lon, precision: 10, scale: 7

      t.timestamps
    end
  end
end
