require 'pry'
require 'rspec'
require 'capybara/rspec'
require 'database_cleaner'
require 'omniauth-github'
require 'dotenv'
require 'launchy'

require_relative '../app.rb'

set :environment, :test

# Omniauth.config.test_mode = true

RSpec.configure do |config|
  config.filter_run focus: true
  config.run_all_when_everything_filtered = true

  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end

def sign_in_as(user)
  OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new({
    :provider => 'github',
    :uid => user.uid
  })
  click_link 'Sign in'
end

Capybara.app = Sinatra::Application
