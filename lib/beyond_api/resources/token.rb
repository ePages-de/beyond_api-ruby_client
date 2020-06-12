# frozen_string_literal: true

require "beyond_api/utils"

module BeyondApi
  class Token
    class InvalidSessionError < StandardError; end

    include BeyondApi::Utils

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

      handle_response(response, status)
    end

    def refresh
      response, status = BeyondApi::Request.token(@session.api_url + "/oauth/token",
                                                  grant_type: "refresh_token",
                                                  refresh_token: @session.refresh_token)

      handle_response(response, status)
    end

    def client_credentials
      response, status = BeyondApi::Request.token(@session.api_url + "/oauth/token",
                                                  grant_type: "client_credentials")

      handle_response(response, status)
    end

    private

    def handle_response(response, status)
      if status.between?(200, 299)
        @session.access_token = response["access_token"]
        @session.refresh_token = response["refresh_token"]
        @session
      else
        handle_error(response, status)
      end
    end
  end
end
