class AddDateToTweets < ActiveRecord::Migration
  def change
      rename_column :tweets, :message, :text
      add_column :tweets, :date, :datetime
      add_column :tweets, :tweet_id, :integer
  end
end
