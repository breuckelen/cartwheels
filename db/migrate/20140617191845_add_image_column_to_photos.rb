class AddImageColumnToPhotos < ActiveRecord::Migration
  def up
      add_attachment :photos, :image
      remove_column :photos, :image_url
  end

  def down
      remove_attachment :photos, :image
      add_column :photos, :image_url, :string
  end
end
