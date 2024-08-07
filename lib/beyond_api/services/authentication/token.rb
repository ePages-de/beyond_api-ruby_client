module BeyondApi
  module Authentication
    class Token < BaseService
      def refresh(refresh_token)
        handle_token_call("refresh_token", refresh_token:)
      end

      def handle_token_call(grant_type, params = {})
        path = "oauth/token"
        @oauth = true

        params.merge!(grant_type:)

        post(path, {}, params)
      end
    end
  end
end
