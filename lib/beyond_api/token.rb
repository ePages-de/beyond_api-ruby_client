# frozen_string_literal: true

require "beyond_api/utils"

module BeyondApi

  class Token
    include Connection

    class InvalidSessionError < StandardError; end

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
      path = "oauth/token?"

      params.merge!(grant_type: grant_type)

      response = agent.post(path) do |request|
        request.params = params
      end

      handle_response(response)
    end

    def handle_response(response)
      if response.status.between?(200, 299)
        @session.access_token = response.body["access_token"]
        @session.refresh_token = response.body["refresh_token"]
        @session
      else
        raise Error.new(response.body, response.status)
      end
    end
  end
end
