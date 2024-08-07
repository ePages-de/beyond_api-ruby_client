# frozen_string_literal: true

module BeyondApi
  class Connection
    LOGGER       = BeyondApi.logger
    LOGGER.level = Kernel.const_get("::Logger::#{BeyondApi.configuration.log_level.to_s.upcase}")

    class << self
      def default
        create_connection do |faraday|
          faraday.headers["Accept"] = 'application/json' # Set default accept header
          faraday.headers["Content-Type"] = 'application/json' # Set default content type
          faraday.request :json # Encode request bodies as JSON
          faraday.request :retry, BeyondApi.configuration.retry_options
          faraday.response :json, content_type: "application/json"
          faraday.response :logger, *logger_config
        end
      end

      def token
        create_connection do |faraday|
          faraday.headers["Accept"] = "application/json"
          faraday.request :basic_auth, BeyondApi.configuration.client_id, BeyondApi.configuration.client_secret
          faraday.response :logger, *logger_config { |logger| apply_filters(logger) }
        end
      end

      def multipart
        create_connection do |faraday|
          faraday.adapter Faraday.default_adapter
          faraday.request :multipart, flat_encode: true
        end
      end

      private

      def create_connection
        Faraday.new(ssl: { verify: true }) do |faraday|
          faraday.options.timeout      = BeyondApi.configuration.timeout.to_i
          faraday.options.open_timeout = BeyondApi.configuration.open_timeout.to_i

          yield(faraday) if block_given?
        end
      end

      def logger_config
        [
          LOGGER,
          bodies: BeyondApi.configuration.log_bodies,
          headers: BeyondApi.configuration.log_headers
        ]
      end

      def apply_filters(logger)
        logger.filter(/(code=)([a-zA-Z0-9]+)/, '\1[FILTERED]')
        logger.filter(/(refresh_token=)([a-zA-Z0-9.\-\_]+)/, '\1[FILTERED]')
      end
    end
  end
end
