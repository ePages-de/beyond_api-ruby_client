# frozen_string_literal: true

require "beyond_api/version"

require "logger"

require "beyond_api/ext"
require "beyond_api/utils"

module BeyondApi
  autoload :Connection, "beyond_api/connection"
  autoload :Error,      "beyond_api/error"
  autoload :Logger,     "beyond_api/logger"
  autoload :Request,    "beyond_api/request"
  autoload :Session,    "beyond_api/session"

  extend BeyondApi::Logger

  class << self
    attr_accessor :configuration
  end

  def self.setup
    self.configuration ||= Configuration.new

    yield configuration
  end

  class Configuration
    attr_accessor :client_id, :client_secret, :open_timeout, :timeout, :remove_response_links,
                  :remove_response_key_underscores, :object_struct_responses, :raise_error_requests,
                  :log_headers, :log_bodies, :log_level, :all_pagination_size

    def initialize
      @client_id = nil
      @client_secret = nil
      @open_timeout = 2
      @timeout = 5
      @remove_response_links = false
      @remove_response_key_underscores = false
      @object_struct_responses = false
      @raise_error_requests = false

      @log_level = :info
      @log_headers = false
      @log_bodies = false

      @all_pagination_size = 200
    end
  end
end
