# frozen_string_literal: true

module BeyondApi
  module Concerns
    module Connection
      LOGGER       = BeyondApi.logger
      LOGGER.level = Kernel.const_get("::Logger::#{BeyondApi.configuration.log_level.to_s.upcase}")

      def get(path, params = {})
        parsed_response agent.get(path, parsed_request(params))
      end

      def post(path, body = {}, params = {})
        response = agent.post(path, body) do |request|
          request.params = parsed_request(params)
          request.body = parsed_request(body)
        end
        parsed_response(response)
      end

      def delete(path, params = {})
        parsed_response agent.delete(path, parsed_request(params))
      end

      private

      def parsed_response(response)
        Response.new(response).handle
      end

      def parsed_request(hash)
        Utils.camelize_keys(hash)
      end

      def agent
        @agent ||= Faraday.new(url: @session.api_url, ssl: { verify: true }) do |faraday|
          # Timeouts
          faraday.options.timeout      = BeyondApi.configuration.timeout.to_i
          faraday.options.open_timeout = BeyondApi.configuration.open_timeout.to_i
          # Authorization
          case @authorization
          when :basic
            faraday.request :authorization, :basic, BeyondApi.configuration.client_id,
                            BeyondApi.configuration.client_secret
          when :bearer
            faraday.request :authorization, "Bearer", @session.access_token
          end
          # Headers
          faraday.headers["Accept"] = "application/json" # Set default accept header
          faraday.headers["Content-Type"] = "application/json" # Set default content type
          # Request options
          faraday.request :json # Encode request bodies as JSON
          faraday.request :retry, BeyondApi.configuration.retry_options
          # Response options
          faraday.response :json, content_type: "application/json"
          faraday.response :logger, *logger_config { |logger| apply_filters(logger) }
        end
      end

      def apply_filters(logger)
        logger.filter(/(code=)([a-zA-Z0-9]+)/, '\1[FILTERED]')
        logger.filter(/(refresh_token=)([a-zA-Z0-9.\-\_]+)/, '\1[FILTERED]')
      end

      # def multipart
      #   create_connection do |faraday|
      #     faraday.adapter Faraday.default_adapter
      #     faraday.request :multipart, flat_encode: true
      #   end
      # end

      def logger_config
        [
          LOGGER,
          { bodies: BeyondApi.configuration.log_bodies,
            headers: BeyondApi.configuration.log_headers }
        ]
      end
    end
  end
end
