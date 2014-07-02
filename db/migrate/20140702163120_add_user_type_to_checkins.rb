class AddUserTypeToCheckins < ActiveRecord::Migration
  def change
    add_column :checkins, :user_type, :string
  end
end
