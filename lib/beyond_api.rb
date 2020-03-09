require "beyond_api/version"

require "beyond_api/connection"
require "beyond_api/request"
require "beyond_api/session"
require "beyond_api/error"

require "beyond_api/ext"
require "beyond_api/utils"

require "logger"

module BeyondApi
  def self.logger
    @@logger ||= defined?(Rails) ? Rails.logger : Logger.new(STDOUT)
  end

  def self.logger=(logger)
    @@logger = logger
  end

  class << self
    attr_accessor :configuration
  end

  def self.setup
    self.configuration ||= Configuration.new

    yield configuration
  end

  class Configuration
    attr_accessor :client_id, :client_secret, :open_timeout, :timeout,  :remove_response_links,
                  :remove_response_key_underscores, :object_struct_responses, :raise_error_requests

    def initialize
      @client_id = nil
      @client_secret = nil
      @open_timeout = 2
      @timeout = 5
      @remove_response_links = false
      @remove_response_key_underscores = false
      @object_struct_responses = false
      @raise_error_requests = false
    end
  end
end
