class CreateBadgesUsers < ActiveRecord::Migration
  def change
    create_table :badges_users do |t|
        t.integer :badge_id
        t.integer :user_id
    end
  end
end
