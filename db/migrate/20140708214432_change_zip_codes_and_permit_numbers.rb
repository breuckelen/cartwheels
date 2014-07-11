class ChangeZipCodesAndPermitNumbers < ActiveRecord::Migration
  def change
      change_column :carts, :zip_code, :string
      change_column :users, :zip_code, :string
      change_column :carts, :permit_number, :string
  end
end
