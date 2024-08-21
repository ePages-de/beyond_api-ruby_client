# frozen_string_literal: true

module BeyondApi
  module Concerns
    module Connection
      LOGGER = BeyondApi.logger
      LOGGER.level = Kernel.const_get("::Logger::#{BeyondApi.configuration.log_level.to_s.upcase}")

      def get(path, params = {})
        handle_request { agent.get(path, parse_request(params)) }
      end

      def put(path, body = {}, params = {})
        handle_request do
          agent.put(path, body) do |request|
            request.params = parse_request(params)
            request.body   = parse_request(body)
          end
        end
      end

      def post(path, body = {}, params = {})
        handle_request do
          agent.post(path, body) do |request|
            request.params = parse_request(params)
            request.body   = parse_request(body)
          end
        end
      end

      def delete(path, params = {})
        handle_request { agent.delete(path, parse_request(params)) }
      end

      def upload_image(path, image_path, params = {})
        handle_request do
          agent.post(path) do |request|
            request.headers['Content-Type'] = Utils.file_content_type(image_path)
            request.params = parse_request(params)
            request.body = File.binread(image_path)
          end
        end
      end

      # FIXME: Use multipart flat_encode: true
      def upload_images(path, files, params = {})
        handle_request do
          agent.post(path) do |request|
            request.headers['Content-Type'] = 'multipart/form-data'
            request.options[:params_encoder] = Faraday::FlatParamsEncoder
            request.params = parse_request(params)
            request.body   = { image: files_to_upload(files) }
          end
        end
      end

      private

      def parse_request(hash)
        return hash unless @camelize_keys

        Utils.camelize_keys(hash)
      end

      def handle_request
        Response.new(yield).parse
      rescue Faraday::TimeoutError, Faraday::ConnectionFailed => e
        raise BeyondApi::FaradayError, e
      end

      def agent
        @agent ||= Faraday.new(url: @session.api_url, ssl: { verify: true }) do |faraday|
          # Timeouts
          faraday.options.timeout      = BeyondApi.configuration.timeout.to_i
          faraday.options.open_timeout = BeyondApi.configuration.open_timeout.to_i
          # Authorization
          faraday.request :authorization, *authorization_config
          # Headers
          faraday.headers['Accept'] = 'application/json' # Set default accept header
          faraday.headers['Content-Type'] = 'application/json' # Set default content type
          # Request options
          faraday.request :json # Encode request bodies as JSON
          faraday.request :retry, BeyondApi.configuration.retry_options
          # Response options
          faraday.response :json, content_type: 'application/json'
          faraday.response :logger, *logger_config { |logger| apply_filters(logger) }
        end
      end

      def authorization_config
        case @authorization
        when :basic
          [:basic, BeyondApi.configuration.client_id, BeyondApi.configuration.client_secret]
        when :bearer
          ['Bearer', @session.access_token]
        end
      end

      def logger_config
        [LOGGER, { bodies: BeyondApi.configuration.log_bodies, headers: BeyondApi.configuration.log_headers }]
      end

      def apply_filters(logger)
        logger.filter(/(code=)([a-zA-Z0-9]+)/, '\1[FILTERED]')
        logger.filter(/(refresh_token=)([a-zA-Z0-9.\-\_]+)/, '\1[FILTERED]')
      end

      def files_to_upload(files)
        files.map { |file| Faraday::Multipart::FilePart.new(File.open(file), Utils.file_content_type(file)) }
      end
    end
  end
end
