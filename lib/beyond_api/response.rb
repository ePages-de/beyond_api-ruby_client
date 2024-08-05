# frozen_string_literal: true

require "json"
require "faraday"
require "beyond_api/utils"
require "forwardable"

module BeyondApi
  class Response
    extend Forwardable

    def_delegators :@response, :success?, :body, :status

    def initialize(response)
      @response = response
    end

    def handle
      success? ? sanitize_response(body) : handle_error
    end

    private

    def sanitize_key(key)
      key.chars.first == "_" ? key[1..-1] : key
    end

    def sanitize_response(hash)
      {}.tap do |h|
        hash.each do |key, value|
          next if key == "_links" && BeyondApi.configuration.remove_response_links

          key = sanitize_key(key) if BeyondApi.configuration.remove_response_key_underscores
          h[key.underscore.to_sym] = transform(value)
        end
      end
    end

    def transform(thing)
      case thing
      when Hash then sanitize_response(thing)
      when Array then thing.map { |v| transform(v) }
      else; thing
      end
    end

    def handle_error
      raise BeyondApi::Error.new(body, status)
      # BeyondApi.logger.error "[Beyond API] #{status}: #{response}"
      # error = BeyondApi::Error.new(response, status)
      # BeyondApi.configuration.raise_error_requests ? raise(error) : error
    end
  end
end
