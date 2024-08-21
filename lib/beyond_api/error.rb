# frozen_string_literal: true

module BeyondApi
  class Error < StandardError
    attr_reader :response

    def initialize(response)
      @response = response

      super
    end
  end
end
