# frozen_string_literal: true

module BeyondApi
  module Authentication
    # @example How to instantiate a client
    #   @client = BeyondApi::Authentication::UserAndPassword.new(
    #     api_url: 'https://example.com/api',
    #     access_token: 'your_token'
    #   )
    class UserAndPassword < BaseService
      # Verify a password against the password guidelines.
      #
      # @see https://developer.epages.com/beyond-docs/#verify_password
      #
      # @option params [Integer] :user_role the type of user. Can be one of merchant, support, or customer.
      # @option params [String] :password the password that needs to be verified.
      #
      # @example
      #   @client.verify_password(
      #     "merchant",
      #     "ValidPassword!"
      #   )
      def verify_password(user_role, password)
        post(
          'users/verify-password',
          { password: }, # body
          user_role # query params
        )
      end

      # Trigger an email address change
      #
      # @see https://developer.epages.com/beyond-docs/#change_password
      #
      # @option params [Integer] :user_id
      # @option params [String] :current_password the current password of the user. This is verified before the password change.
      # @option params [String] :new_password the new password to set in order to change the password.
      #
      # @example
      #   @client.change_password(
      #     "9ed8418f-d568-4327-9f20-ec1d00614398",
      #     "GoodPassword01!;)",
      #     "ValidPassword123"
      #   )
      def change_password(user_id, current_password, new_password)
        post(
          "users/#{user_id}/change-password",
          { current_password:, new_password: } # body
        )
      end

      # Trigger an email address change
      #
      # @see https://developer.epages.com/beyond-docs/#trigger_password_reset_email
      #
      # @option params [String] :email the email address of the user account.
      #
      # @example
      #   @client.password_reset_email(
      #     "baxter@example.org"
      #   )
      def password_reset_email(email)
        post(
          'users/reset-password-request',
          { email: } # body
        )
      end

      # Change the username of a user.
      #
      # @see https://developer.epages.com/beyond-docs/#change_username
      #
      # @option params [Integer] :user_id the email address of the user account.
      # @option params [String] :current_password The current password of the user. This is verified before the username change.
      # @option params [String] :new_username The new username to set in order to change the username.
      #
      # @example
      #   @client.change_username(
      #     "9ed8418f-d568-4327-9f20-ec1d00614398",
      #     "ValidPassword123",
      #     "baxter2@example.org"
      #     )
      def change_username(user_id, current_password, new_username)
        post(
          "users/#{user_id}/change-username",
          { current_password:, new_username: }, # body
          user_role # query params
        )
      end
    end
  end
end
