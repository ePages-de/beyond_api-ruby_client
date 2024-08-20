# frozen_string_literal: true

module BeyondApi
  module Authentication
    # @example How to instantiate a client
    #   @client = BeyondApi::Authentication::Token.new(api_url: 'https://example.com/api')
    class Token < BaseService
      def initialize(**params)
        super
        @authorization = :basic
        @camelize_keys = false
      end

      # Create a JsonWebToken from a refresh token.
      #
      # @return [Hash]
      #
      # @see https://developer.epages.com/beyond-docs/#create_a_jsonwebtoken_from_refresh_token
      #
      # @example
      #   @client.refresh_token('your_refresh_token')
      def refresh(refresh_token)
        post('oauth/token', {}, { grant_type: 'refresh_token', refresh_token: })
      end

      # Create a JsonWebToken from a refresh token.
      #
      # @return [Hash]
      #
      # @see https://developer.epages.com/beyond-docs/#create_a_jsonwebtoken_from_refresh_token
      #
      # @example
      #   @client.refresh_token('GY_GTp')
      def get(code)
        post('oauth/token', {}, { grant_type: 'authorization_code', code: })
      end

      # Create a a JsonWebToken using the client_credentials grant type.
      #
      # @return [Hash]
      #
      # @see https://developer.epages.com/beyond-docs/#create_a_jsonwebtoken_from_client_credentials
      #
      # @example
      #   @client.refresh_token("GY_GTp")
      def client_credentials
        post('oauth/token', {}, { grant_type: 'client_credentials' })
      end
    end
  end
end
