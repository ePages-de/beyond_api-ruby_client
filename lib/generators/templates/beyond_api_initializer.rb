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

  # Configure the pagination size when `paginated: false` is sent on `.all()` requests. Value must be between 1 and 1000.
  # config.all_pagination_size = 200

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

  # ==> Retry configuration
  # Configure the retry options for requests. Default is:
  # config.retry_options = {
  #   max: 5,
  #   interval: 0.05,
  #   interval_randomness: 0.5,
  #   backoff_factor: 2,
  #   retry_statuses: [409],
  #   exceptions: [Faraday::TimeoutError, Faraday::ConnectionFailed]
  # }
  # Or you can set single retry options like this:
  # config.retry_options[:max] = 5
  # config.retry_options[:interval] = 1
end
