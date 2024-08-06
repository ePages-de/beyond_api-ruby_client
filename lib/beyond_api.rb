# frozen_string_literal: true

require "beyond_api/version"

require "logger"

require "beyond_api/ext"
require "beyond_api/utils"
require "beyond_api/services/base_service"
require "beyond_api/services/product_management/image"
require "beyond_api/services/product_management/product"
require "beyond_api/services/product_management/variation"
require "beyond_api/services/product_management/variation_image"
require "beyond_api/services/product_view/category"
require "beyond_api/services/storefront/script_tag"
require "beyond_api/services/checkout/shipping_zone"
require "beyond_api/services/shop/address"
require "beyond_api/services/shop/shop"

module BeyondApi
  autoload :Connection, "beyond_api/connection"
  autoload :Error,      "beyond_api/error"
  autoload :Logger,     "beyond_api/logger"
  autoload :Request,    "beyond_api/request"
  autoload :Response,   "beyond_api/response"
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
