require 'rails_helper'

RSpec.configure do |config|
  Capybara.javascript_driver = :webkit_debug
  Capybara.default_max_wait_time = 10
  Capybara.ignore_hidden_elements = false
  config.use_transactional_fixtures = false

  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each, js: true) do
    DatabaseCleaner.strategy = :truncation
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

  Capybara::Webkit.configure do |config|
    config.block_unknown_urls
  end
end
