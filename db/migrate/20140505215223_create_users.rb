class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
        t.string :email
        t.string :username
        t.string :password
        t.integer :zip_code
        t.timestamps
    end
  end
end
