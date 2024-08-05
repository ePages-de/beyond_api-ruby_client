# frozen_string_literal: true

require "json"
require "faraday"
require "beyond_api/utils"
require "forwardable"

module BeyondApi
  class Response
    extend Forwardable
    def initialize(response)
      @response = response
    end
  end
end
