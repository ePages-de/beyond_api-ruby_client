# frozen_string_literal: true

module BeyondApi
  class Connection
    class << self
      def token
        create_connection do |faraday|
          faraday.headers["Accept"] = "application/json"
          faraday.request :authorization, :basic, BeyondApi.configuration.client_id, BeyondApi.configuration.client_secret
          faraday.response :logger, *logger_config { |logger| apply_filters(logger) }
        end
      end
    end
    def create_connection
      Faraday.new(ssl: { verify: true }) do |faraday|
        faraday.options.timeout      = BeyondApi.configuration.timeout.to_i
        faraday.options.open_timeout = BeyondApi.configuration.open_timeout.to_i

        yield(faraday) if block_given?
      end
    end
  end
  class Request
    def self.token(url, params)
      response = BeyondApi::Connection.token.post do |request|
        request.url(url)
        request.params = params
      end

      [response.body.blank? ? nil : JSON.parse(response.body), response.status]
    end
  end
end
