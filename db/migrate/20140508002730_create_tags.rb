class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :name
      t.integer :count, default: 0

      t.timestamps
    end

    add_index :tags, :text
  end
end
