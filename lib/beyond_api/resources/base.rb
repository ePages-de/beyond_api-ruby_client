# frozen_string_literal: true

module BeyondApi
  class Base
    class InvalidSessionError < StandardError; end

    attr_reader :session

    def initialize(session)
      @session = session

      raise InvalidSessionError, "Invalid session" unless session.is_a? BeyondApi::Session
      raise InvalidSessionError, "Session api_url cannot be nil" if session.api_url.nil?
    end
  end
end
