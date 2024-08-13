# frozen_string_literal: true

module BeyondApi
  class Response
    extend Forwardable

    def_delegators :@response, :success?, :body, :status

    def initialize(response)
      @response = response
    end

    def parse
      success? ? parsed_response : raise_error
    end

    private

    def parsed_response
      return {} if body.blank?

      body.deep_transform_keys! do |key|
        key = remove_initial_underscore(key)
        key = snake_case_key(key)
        key.to_sym
      end
    end

    def remove_initial_underscore(key)
      key.to_s.starts_with?("_") ? key[1..] : key
    end

    def snake_case_key(key)
      key.to_s.underscore
    end

    def raise_error
      raise Error, parsed_response
    end
  end
end
