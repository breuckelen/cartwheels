# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!

ENV['RAILS_ENV'] ||= 'production'

if Rails.env.production?
    ENV['BASIC_AUTH_USERNAME'] = 'cartwheels'
    ENV['BASIC_AUTH_PASSWORD'] = '9Ca$#@368'
end
