class CreateSearchItems < ActiveRecord::Migration
  def change
    create_table :search_items do |t|
        t.text :terms
        t.integer :search_history_id
        t.timestamps
    end
  end
end
