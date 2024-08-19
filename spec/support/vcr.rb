require "jwt"
require "vcr"

VCR.configure do |config|
  config.cassette_library_dir = "spec/vcr_cassettes"
  config.hook_into :webmock
  config.configure_rspec_metadata!
  config.ignore_localhost = true
  config.default_cassette_options = {
    match_requests_on: [ :method, :uri, :body ]
  }

  config.filter_sensitive_data("<ACCESS_TOKEN>") do |interaction|
    authorizations = interaction.request.headers["Authorization"].first
    if (match = authorizations.match(/^(Bearer|Basic)\s+([^,\s]+)/))
      match.captures.last
    end
  end

  config.filter_sensitive_data("<ACCESS_TOKEN>") do |interaction|
    response_body = JSON.parse(interaction.response.body)
    response_body["access_token"] if response_body.is_a?(Hash)
  rescue JSON::ParserError
    nil
  end

  config.filter_sensitive_data("<REFRESH_TOKEN>") do |interaction|
    response_body = JSON.parse(interaction.response.body)
    response_body["refresh_token"] if response_body.is_a?(Hash)
  rescue JSON::ParserError
    nil
  end

  config.filter_sensitive_data("<REFRESH_TOKEN>") do |interaction|
    ENV["REFRESH_TOKEN"]
  end

  config.filter_sensitive_data("<ACCESS_TOKEN>") do |interaction|
    JWT.encode({ exp: (DateTime.now + 1.year).to_i }, nil, "HS256")
  end
end
