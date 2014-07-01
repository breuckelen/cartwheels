class AddAuthenticationTokenToOwners < ActiveRecord::Migration
  def change
    add_column :owners, :authentication_token, :string
  end
end
