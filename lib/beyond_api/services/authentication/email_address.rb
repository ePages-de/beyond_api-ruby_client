# frozen_string_literal: true

module BeyondApi
  module Authentication
    # @example How to instantiate a client
    #   @client = BeyondApi::Authentication::EmailAddress.new(
    #     api_url: 'https://example.com/api',
    #     access_token: 'your_token'
    #   )
    class EmailAddress < BaseService
      # Trigger an email address change
      #
      # @see https://developer.epages.com/beyond-docs/#trigger_email_address_change
      #
      # @option params [Integer] :user_id
      # @option params [String] :locale defines the language of the confirmation email is to be sent.
      # @option params [String] :current_password the current password of the user account.
      # @option params [String] :new_email the new email address for the user to set.
      #
      # @example
      #   @client.trigger_change(
      #     "9ed8418f-d568-4327-9f20-ec1d00614398",
      #     "en-US",
      #     "GoodPassword01!;)",
      #     "new.email@epages.com"
      #     )
      def trigger_change(user_id, locale, current_password, new_email)
        post(
          "users/#{user_id}/change-email-request",
          { current_password:, new_email: }, # body
          locale # query params
        )
      end
    end
  end
end
