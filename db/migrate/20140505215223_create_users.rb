class CreateUsers < ActiveRecord::Migration
    def change
        create_table :users do |t|
            t.string :email_encrypted
            t.string :username
            t.string :password_encrypted
            t.integer :zip_code

            t.timestamps
        end

        add_index :users, [:created_at, :username]
        add_index :users, [:created_at, :zip_code]
    end
end
