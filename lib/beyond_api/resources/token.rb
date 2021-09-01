# frozen_string_literal: true

require "beyond_api/utils"

module BeyondApi
  class Token
    class InvalidSessionError < StandardError; end

    include BeyondApi::Utils

    attr_reader :session

    def initialize(session)
      @session = session

      raise InvalidSessionError, "Invalid session" unless session.is_a? BeyondApi::Session
      raise InvalidSessionError, "Session api_url cannot be nil" if session.api_url.nil?
    end

    def authorization_code(code)
      handle_token_call("authorization_code", code: code)
    end

    def refresh_token
      handle_token_call("refresh_token", refresh_token: @session.refresh_token)
    end

    def client_credentials
      handle_token_call("client_credentials")
    end

    alias refresh refresh_token
    alias create authorization_code

    private

    def handle_token_call(grant_type, params = {})
      params.merge!(grant_type: grant_type)

      response, status = BeyondApi::Request.token("#{@session.api_url}/oauth/token",
                                                  params)

      handle_response(response, status)
    end

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
