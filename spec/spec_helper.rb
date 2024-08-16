# frozen_string_literal: true

require "bundler/setup"
require "dotenv/load"
require "beyond_api"
require "factory_bot"

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.include FactoryBot::Syntax::Methods

  config.before(:suite) do
    FactoryBot.find_definitions
  end

  AppRoot = File.expand_path(File.dirname("vcr.rb"))

  load "#{AppRoot}/spec/support/vcr.rb"
end

BeyondApi.setup do |config|
  config.client_id = ENV["CLIENT_ID"]
  config.client_secret = ENV["CLIENT_SECRET"]
end

def auth_client
  BeyondApi::Authentication::Token.new(
    api_url: ENV["API_URL"],
    client_id: ENV["CLIENT_ID"],
    client_secret: ENV["CLIENT_SECRET"]
  )
end
