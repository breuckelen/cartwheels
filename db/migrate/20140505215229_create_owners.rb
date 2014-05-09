class CreateOwners < ActiveRecord::Migration
  def change
    create_table :owners do |t|
        t.string :email_encrypted
        t.string :password_encrypted

        t.timestamps
    end
  end
end
