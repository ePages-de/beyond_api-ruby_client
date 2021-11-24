require "bundler/setup"
require "dotenv/load"
require "beyond_api"
require "dotenv/load"

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

unless ENV["CLIENT_ID"].nil? and ENV["CLIENT_SECRET"].nil?
  BeyondApi.setup do |config|
    config.client_id = ENV["CLIENT_ID"]
    config.client_secret = ENV["CLIENT_SECRET"]
    config.remove_response_links = true
    config.remove_response_key_underscores = true
    config.object_struct_responses = true
  end
end
