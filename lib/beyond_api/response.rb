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

    def sanitize_response(hash)
      return {} if hash.blank?

      {}.tap do |response_hash|
        hash.each do |key, value|
          key = remove_initial_underscore(key)
          key = symbolize_key(key)

          response_hash[key] = sanitize_value(value)
        end
      end
    end

    def remove_initial_underscore(key)
      key.chars.first == "_" ? key[1..-1] : key
    end

    def symbolize_key(key)
      key.underscore.to_sym
    end

    def sanitize_value(value)
      case value
      when Hash
        sanitize_response(value)
      when Array
        value.map { |v| sanitize_value(v) }
      else
        value
      end
    end

    def handle_error
      raise BeyondApi::Error.new(body, status)
    end
  end
end
