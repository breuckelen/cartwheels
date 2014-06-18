class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
        t.text :text
        t.integer :rating, precision: 1
        t.integer :cart_id
        t.integer :user_id

        t.timestamps
    end

    add_index :reviews, :cart_id
    add_index :reviews, :user_id
  end
end
