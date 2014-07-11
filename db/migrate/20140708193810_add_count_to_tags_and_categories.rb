class AddCountToTagsAndCategories < ActiveRecord::Migration
  def change
      add_column :categories, :count, :integer, default: 0
      add_column :tags, :count, :integer, default: 0
  end
end
