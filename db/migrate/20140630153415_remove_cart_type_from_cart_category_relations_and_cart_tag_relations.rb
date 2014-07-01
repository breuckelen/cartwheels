class RemoveCartTypeFromCartCategoryRelationsAndCartTagRelations < ActiveRecord::Migration
  def change
      remove_column :cart_category_relations, :cart_type
      remove_column :cart_tag_relations, :cart_type
  end
end
