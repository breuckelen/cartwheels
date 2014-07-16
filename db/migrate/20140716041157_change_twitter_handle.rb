class ChangeTwitterHandle < ActiveRecord::Migration
  def change
      change_column :carts, :twitter_handle, :string
  end
end
