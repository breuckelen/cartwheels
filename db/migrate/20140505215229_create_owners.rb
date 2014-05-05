class CreateOwners < ActiveRecord::Migration
  def change
    create_table :owners do |t|
        t.string :email
        t.string :password
        t.timestamps
    end
  end
end
