# frozen_string_literal: true

require "beyond_api/resources/base"
require "beyond_api/resources/token"
require "beyond_api/resources/products"

module BeyondAPI
  class Session
    attr_reader :api_url
    attr_accessor :access_token, :refresh_token

    def initialize(api_url:, access_token: nil, refresh_token: nil)
      @api_url = api_url
      @access_token = access_token
      @refresh_token = refresh_token
    end

    def token
      BeyondAPI::Token.new(self)
    end

    def products
      BeyondAPI::Products.new(self)
    end
  end
end
