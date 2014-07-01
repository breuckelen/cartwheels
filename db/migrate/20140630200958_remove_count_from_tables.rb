class RemoveCountFromTables < ActiveRecord::Migration
  def change
    remove_column :tags, :count
    remove_column :categories, :count
    remove_column :search_tokens, :count
  end
end
