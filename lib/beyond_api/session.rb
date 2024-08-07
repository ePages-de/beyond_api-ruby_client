# frozen_string_literal: true

module BeyondApi
  class Session
    include Connection

    attr_reader :api_url
    attr_accessor :access_token, :refresh_token

    def initialize(api_url:, access_token: nil, refresh_token: nil)
      uri = URI.parse(api_url)

      @api_url = "#{uri.scheme}://#{uri.host}/api"
      @access_token = access_token
      @refresh_token = refresh_token
    end

    def authorization_code(code)
      handle_token_call("authorization_code", code: code)
    end

    def refresh_token
      handle_token_call("refresh_token", refresh_token: refresh_token)
    end

    def get_client_credentials
      handle_token_call("client_credentials")
    end

    alias refresh refresh_token
    alias create authorization_code

    private
    
    def handle_token_call(grant_type, params = {})
      path = "oauth/token"
      @oauth = true

      params.merge!(grant_type: grant_type)

      response = post(path, {}, params)

      @session.access_token = response[:access_token]
      @session.refresh_token = response[:refresh_token]
      @session
    end
  end
end
