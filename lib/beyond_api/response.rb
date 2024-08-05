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

    def failure?
      !success?
    end
  end
end
