class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
        t.text :text
        t.integer :rating, precision: 1
        t.integer :cart_id
        t.integer :user_id
        t.timestamps
    end
  end
end
