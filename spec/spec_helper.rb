# frozen_string_literal: true

require 'bundler/setup'
require 'dotenv/load'
require 'beyond_api'
require 'factory_bot'

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.include FactoryBot::Syntax::Methods

  config.before(:suite) do
    FactoryBot.find_definitions
  end

  app_root = File.expand_path(File.dirname('vcr.rb'))

  load "#{app_root}/spec/support/vcr.rb"
end

BeyondApi.setup do |config|
  config.client_id = ENV.fetch('CLIENT_ID', nil)
  config.client_secret = ENV.fetch('CLIENT_SECRET', nil)
end

def auth_client
  BeyondApi::Authentication::Token.new(api_url: ENV.fetch('API_URL', nil))
end

def beyond_access_token
  auth_client.client_credentials[:access_token]
end
