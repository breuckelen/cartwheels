class CreateAds < ActiveRecord::Migration
  def change
    create_table :ads do |t|
        t.string :title
        t.text :description
        t.datetime :start_date
        t.datetime :end_date
        t.integer :cart_id
        t.integer :ad_type_id
        t.timestamps
    end
  end
end
