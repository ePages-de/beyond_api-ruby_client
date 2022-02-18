# frozen_string_literal: true

require "faraday"
require "logger"

module BeyondApi
  class Connection
    LOGGER = ::BeyondApi.logger
    LOGGER.level = ::Kernel.const_get("::Logger::#{BeyondApi.configuration.log_level.to_s.upcase}")

    def self.default
      Faraday.new(ssl: { verify: true }) do |faraday|
        faraday.options[:open_timeout] = BeyondApi.configuration.open_timeout.to_i
        faraday.options[:timeout] = BeyondApi.configuration.timeout.to_i
        faraday.response :logger, LOGGER, { headers: BeyondApi.configuration.log_headers,
                                            bodies: BeyondApi.configuration.log_bodies }
        faraday.headers["Accept"] = "application/json"
        faraday.headers["Content-Type"] = "application/json"
        faraday.request(:multipart)
        faraday.request(:url_encoded)
        faraday.adapter(:net_http)
      end
    end

    def self.token
      Faraday.new(ssl: { verify: true }) do |faraday|
        faraday.options[:open_timeout] = BeyondApi.configuration.open_timeout.to_i
        faraday.options[:timeout] = BeyondApi.configuration.timeout.to_i
        faraday.response :logger, LOGGER, { headers: BeyondApi.configuration.log_headers,
                                            bodies: BeyondApi.configuration.log_bodies } do |logger|
          logger.filter(/(code=)([a-zA-Z0-9]+)/, '\1[FILTERED]')
          logger.filter(/(refresh_token=)([a-zA-Z0-9.\-\_]+)/, '\1[FILTERED]')
        end
        faraday.headers["Accept"] = "application/json"
        faraday.adapter(:net_http)
        faraday.request :basic_auth, BeyondApi.configuration.client_id, BeyondApi.configuration.client_secret
      end
    end

    def self.multipart
      Faraday.new(ssl: { verify: true }) do |faraday|
        faraday.options[:open_timeout] = BeyondApi.configuration.open_timeout.to_i
        faraday.options[:timeout] = BeyondApi.configuration.timeout.to_i
        faraday.request :multipart, { flat_encode: true }
        faraday.adapter Faraday.default_adapter
      end
    end
  end
end
