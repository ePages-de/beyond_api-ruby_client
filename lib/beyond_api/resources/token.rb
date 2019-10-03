# frozen_string_literal: true

module BeyondApi
  class Token
    class InvalidSessionError < StandardError; end

    attr_reader :session

    def initialize(session)
      @session = session
      raise InvalidSessionError.new("Invalid session") unless session.is_a? BeyondApi::Session
      raise InvalidSessionError.new("Session api_url cannot be nil") if session.api_url.nil?
    end

    def create(code)
      response, status = BeyondApi::Request.token(@session.api_url + "/oauth/token",
                                                  grant_type: "authorization_code",
                                                  code: code)

      if status.between?(200, 299)
        @session.access_token = response["access_token"]
        @session.refresh_token = response["refresh_token"]
      else
        BeyondApi::Error.new(response)
      end
    end

    def refresh
      response, status = BeyondApi::Request.token(@session.api_url + "/oauth/token",
                                                  grant_type: "refresh_token",
                                                  refresh_token: @session.refresh_token)

      if status.between?(200, 299)
        @session.access_token = response["access_token"]
        @session.refresh_token = response["refresh_token"]
      else
        BeyondApi::Error.new(response)
      end
    end
  end
end
