# frozen_string_literal: true

module BeyondApi
  class Error < StandardError
    attr_reader :response, :status

    def initialize(response, status: nil)
      @response = response
      @status = status

      super(response)
    end
  end
end
