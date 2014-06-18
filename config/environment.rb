# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!

if Rails.env.production?
    ENV['SECRET_KEY_BASE'] = '6a7b382a5629802b2faf9fc679d413f1b2c08064d7c3f722a9337dc5770bea0ea7077018977a8e95a9eba8fadd2553abe1e47d46374955b53cb36b95758b77d0'
    ENV['BASIC_AUTH_USERNAME'] = 'cartwheels'
    ENV['BASIC_AUTH_PASSWORD'] = '9Ca$#@368'
end
