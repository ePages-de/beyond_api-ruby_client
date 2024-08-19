# frozen_string_literal: true

module BeyondApi
  module Authentication
    class Token < BaseService
      include Concerns::Connection # @session, @authorization

      def initialize(**params)
        super

        @authorization = :basic
        @camelize_keys = false
      end

      def refresh(refresh_token)
        post('oauth/token', {}, { grant_type: 'refresh_token', refresh_token: })
      end

      def get(code)
        post('oauth/token', {}, { grant_type: 'authorization_code', code: })
      end

      def client_credentials
        post('oauth/token', {}, { grant_type: 'client_credentials' })
      end
    end
  end
end
