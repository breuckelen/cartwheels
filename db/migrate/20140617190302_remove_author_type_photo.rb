class RemoveAuthorTypePhoto < ActiveRecord::Migration
  def up
      remove_column :photos, :author_id
      remove_column :photos, :author_type
      add_column :photos, :user_id, :integer
  end

  def down
      add_column :photos, :author_id, :integer
      add_column :photos, :author_type, :string
  end
end
