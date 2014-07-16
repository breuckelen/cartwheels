class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.integer :cart_id
      t.string :message
      t.timestamps
    end
  end
end
