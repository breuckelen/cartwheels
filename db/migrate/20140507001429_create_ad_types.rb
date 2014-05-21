class CreateAdTypes < ActiveRecord::Migration
  def change
    create_table :ad_types do |t|
        t.string :title
        t.text :description
        t.integer :duration
        t.float :price, precision: 6, scale: 2
    end
  end
end
