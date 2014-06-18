class CreateSearchLines < ActiveRecord::Migration
  def change
    create_table :search_lines do |t|
        t.integer :search_history_id
        t.timestamps
    end

    add_index :search_lines, :search_history_id
  end
end
