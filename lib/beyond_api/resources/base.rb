# frozen_string_literal: true

module BeyondApi
  class Base
    class InvalidSessionError < StandardError; end

    attr_reader :session

    def initialize(session)
      @session = session
      raise InvalidSessionError.new("Invalid session") unless session.is_a? BeyondApi::Session
      if session.api_url.nil? || session.access_token.nil? || session.refresh_token.nil?
        raise InvalidSessionError.new("Session api_url, access_token and refresh_token cannot be nil")
      end
    end
  end
end
