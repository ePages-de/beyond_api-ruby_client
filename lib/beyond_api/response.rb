# frozen_string_literal: true

module BeyondApi
  class Response
    extend Forwardable

    def_delegators :@response, :success?, :body, :status

    def initialize(response)
      @response = response
    end

    def handle
      success? ? parsed_response : raise_error
    end

    private

    def parsed_response
      return {} if body.blank?

      remove_initial_underscore_keys!
      snake_case_keys!
      deep_symbolize_keys!
    end

    def remove_initial_underscore_keys!
      body.deep_transform_keys!{ |key| remove_initial_underscore(key) }
    end

    def snake_case_keys!
      body.deep_transform_keys!{ |key| key.to_s.underscore }
    end

    def deep_symbolize_keys!
      body.deep_symbolize_keys!
    end

    def remove_initial_underscore!
      key.starts_with?('_') ? key[1..-1] : key
    end

    def raise_error
      raise BeyondApi::Error.new(body, status)
    end
  end
end
