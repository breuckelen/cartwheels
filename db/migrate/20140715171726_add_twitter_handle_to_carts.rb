class AddTwitterHandleToCarts < ActiveRecord::Migration
  def change
      add_column :carts, :twitter_handle, :string, default: ''
  end
end
