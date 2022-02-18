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

    BeyondApi.setup do |config|
      config.client_id = ENV["CLIENT_ID"]
      config.client_secret = ENV["CLIENT_SECRET"]
      config.remove_response_links = false
      config.remove_response_key_underscores = true
      config.object_struct_responses = true
      config.log_level = :error
    end
  end

  config.after(:suite) do
    session = BeyondApi::Session.new(api_url: ENV["API_URL"])
    session.token.client_credentials

    products = session.products.all
    products.embedded.products.each do |product|
      session.products.delete(product.id)
    end
  end

  AppRoot = File.expand_path(File.dirname("string.rb"))

  load "#{AppRoot}/lib/beyond_api/core_ext/string.rb"
end
