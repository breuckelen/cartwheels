class RemoveUploadIdFromCarts < ActiveRecord::Migration
  def change
      remove_column :carts, :upload_id
  end
end
