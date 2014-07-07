class ChangeCartDescription < ActiveRecord::Migration
  def change
      change_column :carts, :description, :string, default: ''
  end
end
