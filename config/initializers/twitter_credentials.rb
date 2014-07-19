$client = Twitter::REST::Client.new do |config|
    config.consumer_key    = SECRETS['twitter_key']
    config.consumer_secret = SECRETS['twitter_secret']
end
