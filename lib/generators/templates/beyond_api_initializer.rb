# frozen_string_literal: true

BeyondApi.setup do |config|
  # ==> Client configuration
  config.client_id = nil
  config.client_secret = nil

  # ==> Api configuration
  # Configure the open connection timeout in seconds. Default is 2 seconds.
  # config.open_timeout = 2.seconds

  # Configure the request timeout in seconds. Default is 5 seconds.
  # config.timeout = 5.seconds

  # Transform the Hash responses to ObjectStruct
  # config.object_struct_responses = true
end
