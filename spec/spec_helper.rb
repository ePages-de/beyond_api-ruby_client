# frozen_string_literal: true

require "bundler/setup"
require "dotenv/load"
require "beyond_api"
require "faker"

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  # Initialize BeyondApi
  config.before(:all) do
    BeyondApi.setup do |config|
      config.client_id =     ENV["CLIENT_ID"]
      config.client_secret = ENV["CLIENT_SECRET"]
    end

    @session = BeyondApi::Session.new(api_url:       ENV["Api_URL"],
                                      access_token:  ENV["ACCESS_TOKEN"],
                                      refresh_token: ENV["REFRESH_TOKEN"])
    @session.token.refresh
  end
end
