# frozen_string_literal: true

require 'zeitwerk'
require 'faraday'
require 'faraday/retry'
require 'json'
require 'forwardable'

module BeyondApi
  loader = Zeitwerk::Loader.for_gem
  loader.push_dir("#{__dir__}/beyond_api/services", namespace: BeyondApi)
  loader.ignore("#{__dir__}/generators")
  loader.setup

  extend Logger

  class << self
    attr_accessor :configuration
    
    def setup
      self.configuration ||= Configuration.new
  
      yield configuration
    end
  end

  class Configuration
    attr_accessor :client_id, :client_secret,
                  :open_timeout, :timeout,
                  :log_headers, :log_bodies, :log_level,
                  :all_pagination_size, :retry_options

    def initialize
      @client_id = nil
      @client_secret = nil
      @open_timeout = 2
      @timeout = 5

      @log_level = :info
      @log_headers = false
      @log_bodies = false

      @all_pagination_size = 200

      @retry_options = {
        max: 3,
        interval: 0.05,
        interval_randomness: 0.5,
        backoff_factor: 2,
        retry_statuses: [409],
        exceptions: [Faraday::TimeoutError, Faraday::ConnectionFailed]
      }
    end
  end
end
