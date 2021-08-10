# frozen_string_literal: true

BeyondApi.setup do |config|
  # ==> Client configuration
  config.client_id = nil
  config.client_secret = nil

  config.pagination_size = 200

  # ==> Api configuration
  # Configure the open connection timeout in seconds. Default is 2 seconds.
  # config.open_timeout = 2.seconds

  # Configure the request timeout in seconds. Default is 5 seconds.
  # config.timeout = 5.seconds

  # ==> Log configuration

  # Configure the log level. Must be one of :debug, :info, :warn, :error,
  # :fatal or :unknown. Default is :info.
  #
  # config.log_level = :info

  # Configure is response headers should be logged. Default is false.
  #
  # config.log_headers = false

  # Configure is response bodies should be logged. Default is false.
  #
  # config.log_bodies = false

  # ==> Response configuration
  # Configure if :_links should be removed from response. Default is false and
  # :_links are gonna be part of the response.
  # config.remove_response_links = false

  # Configure if first character underescores should be removed on response hash
  # keys. For example, if set to true, :_id will become :id. Default is false.
  # config.remove_response_key_underscores = false

  # Configure if responses should be transformed to ObjectStructs. If set to
  # true, it gives you the posibility to access response data on a doted way.
  # With OpenStructs => response.embeded.products.first.id
  # Without OpenStructs => response["embeded"]["products"].first["id"]
  # config.object_struct_responses = false

  # Configure if the gem should raise on error requests. Setting it to true is
  # useful for working with exceptions. Setting it to false  will return a
  # BeyondApi::Error object with detailed information of the error.
  # Default is false.
  # config.raise_error_requests = false
end
