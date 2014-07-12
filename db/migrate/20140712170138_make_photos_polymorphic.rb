class MakePhotosPolymorphic < ActiveRecord::Migration
  def change
      remove_column :photos, :user_id
      add_column :photos, :author_id, :integer
      add_column :photos, :author_type, :string
  end
end
