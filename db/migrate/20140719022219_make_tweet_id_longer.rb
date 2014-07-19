class MakeTweetIdLonger < ActiveRecord::Migration
  def change
      change_column :tweets, :tweet_id, :integer, limit: 8
  end
end
