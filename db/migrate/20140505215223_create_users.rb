class CreateUsers < ActiveRecord::Migration
    def change
        create_table :users do |t|
            t.string :name, :default => ''
            t.string :email_encrypted
            t.string :password_encrypted
            t.integer :zip_code, :default => -1

            t.timestamps
        end

        add_index :users, [:created_at, :zip_code]
    end
end
