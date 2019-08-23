# frozen_string_literal: true

require 'faraday'

module BeyondAPI
  class Connection
    def self.default
      Faraday.new(ssl: { verify: true }) do |faraday|
        faraday.options[:open_timeout] = BeyondAPI.configuration.open_timeout.to_i
        faraday.options[:timeout] = BeyondAPI.configuration.timeout.to_i
        faraday.headers['Accept'] = 'application/json'
        faraday.headers['Content-Type'] = 'application/json'
        faraday.request(:multipart)
        faraday.request(:url_encoded)
        faraday.adapter(:net_http)
      end
    end

    def self.token
      Faraday.new(ssl: { verify: true }) do |faraday|
        faraday.options[:open_timeout] = BeyondAPI.configuration.open_timeout.to_i
        faraday.options[:timeout] = BeyondAPI.configuration.timeout.to_i
        faraday.headers['Accept'] = 'application/json'
        faraday.adapter(:net_http)
        faraday.basic_auth(BeyondAPI.configuration.client_id,
                           BeyondAPI.configuration.client_secret)
      end
    end
  end
end
