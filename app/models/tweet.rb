class Tweet < ActiveRecord::Base
    belongs_to :cart

    validates :text, :date, :tweet_id, :cart, presence: true
    validates :tweet_id, uniqueness: true

    # get tweets within the last day
    def self.latest
        where(created_at: (Time.now - 1.day)..Time.now)
    end
end
