# frozen_string_literal: true

module BeyondApi
  class AuthError < StandardError
    attr_reader :error, :error_description

    def initialize(data, status_code = nil)
      @error     = data['error']
      @error_description      = data['error_description']
      @full_message = data
      @status_code  = status_code

      super(data['error_description'])
    end
  end
end
