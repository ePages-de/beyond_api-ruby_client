# frozen_string_literal: true

module BeyondApi
  class Session
    class InvalidUriProtocolError < StandardError; end

    attr_reader :api_url
    attr_accessor :access_token, :refresh_token

    def initialize(api_url:, access_token: nil, refresh_token: nil)
      raise InvalidUriProtocolError, "Invalid URI protocol" unless api_url.start_with? "https://"

      uri = URI.parse(api_url)

      @api_url = "#{uri.scheme}://#{uri.host}/api"
      @access_token = access_token
      @refresh_token = refresh_token
    end

    def token
      Token.new(self)
    end
  end
end
