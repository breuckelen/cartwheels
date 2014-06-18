class AddRolesMaskToUsers < ActiveRecord::Migration
  def up
      add_column :users, :roles_mask, :integer, default: 0
  end

  def down
      remove_column :users, :roles_mask
  end
end
