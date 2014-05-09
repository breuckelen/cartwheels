class CreateSearchHistories < ActiveRecord::Migration
  def change
    create_table :search_histories do |t|
        t.integer :user_id

        t.timestamps
    end

    add_index :search_histories, :user_id
  end
end
