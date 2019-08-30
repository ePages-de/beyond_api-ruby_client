# frozen_string_literal: true

require "beyond_api/utils"

module BeyondAPI
  class Users < Base
    include BeyondAPI::Utils

    #
    # A +GET+ request is used to list all users visible to the current user. This request will not list the support user.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/users' -i -X GET \
    #       -H 'Content-Type: application/json' \
    #       -H 'Accept: application/hal+json' \
    #       -H 'Authorization: Bearer <Access token>'
    #
    # @beyond_api.scopes +user:r+
    #
    # @option params [Integer] :size the page size
    # @option params [Integer] :page the page number
    #
    # @return [OpenStruct]
    #
    # @example
    #   session.users.all(params = {})
    #
    def all(params = {})
      response, status = BeyondAPI::Request.get(@session, "/users")

      handle_response(response, status)
    end

    #
    # A +GET+ request is used to retrieve the details of a user.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/users/e4b528ce-bb9e-4cc5-95e1-7dadfa4cf0f3' -i -X GET \
    #       -H 'Content-Type: application/json' \
    #       -H 'Accept: application/hal+json' \
    #       -H 'Authorization: Bearer <Access token>'
    #
    # @beyond_api.scopes +user:r+
    #
    # @param user_id [String] the user UUID
    #
    # @return [OpenStruct]
    #
    # @example
    #   session.users.find(user_id)
    #
    def find(user_id)
      response, status = BeyondAPI::Request.get(@session, "/users/#{user_id}")

      handle_response(response, status)
    end

    #
    # A +POST+ request is used to create a user.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/users' -i -X POST \
    #       -H 'Content-Type: application/json' \
    #       -H 'Accept: application/json' \
    #       -H 'Authorization: Bearer <Access token>' \
    #       -d '{
    #     "username" : "user",
    #     "password" : "GoodPassword01!;)",
    #     "email" : "baxter@example.org"
    #   }'
    #
    # @beyond_api.scopes +user:c+
    #
    # @param body [Hash] the request body
    #
    # @return [OpenStruct]
    #
    # @example
    #   session.users.create(body)
    #
    def create(body)
      response, status = BeyondAPI::Request.post(@session, "/users", body)

      handle_response(response, status)
    end

    #
    # A +GET+ request is used to list all roles of a user.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/users/0d4bd0a5-94dc-498e-b6a6-305c619bb20d/roles' -i -X GET \
    #       -H 'Authorization: Bearer <Access token>'
    #
    # @beyond_api.scopes +user:r+
    #
    # @param user_id [String] the user UUID
    #
    # @return [OpenStruct]
    #
    # @example
    #   session.users.roles(user_id)
    #
    def roles(user_id)
      response, status = BeyondAPI::Request.get(@session, "/users/#{user_id}/roles")

      handle_response(response, status)
    end

    #
    # A +PUT+ request is used set the roles of a user.
    #
    # @beyond_api.scopes +user:u+
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/users/cfd08a92-dc96-4947-8142-1b6021177f60/roles' -i -X PUT \
    #       -H 'Content-Type: text/uri-list' \
    #       -H 'Authorization: Bearer <Access token>' \
    #       -d 'https://api-shop.beyondshop.cloud/api/roles/165fee2b-f87e-4f33-b036-14b8d96d927a'
    #
    # @param user_id [String] the user UUID
    # @param body [Hash] the request body
    #
    # @return true
    #
    # @example
    #   session.users.set_roles(user_id, body)
    #
    def set_roles(user_id, body)
      response, status = BeyondAPI::Request.put(@session, "/users/#{user_id}/roles", body)

      handle_response(response, status, respond_with_true: true)
    end

    #
    # A +POST+ request is used to add the roles of a user.
    #
    # @beyond_api.scopes +user:r+, +user:u+
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/users/ac186856-59c4-4d78-a444-8c47ff623525/roles' -i -X POST \
    #       -H 'Content-Type: text/uri-list' \
    #       -H 'Authorization: Bearer <Access token>' \
    #       -d 'https://api-shop.beyondshop.cloud/api/roles/4553f87f-d232-4bf6-8e15-34c373661e82'
    #
    # @param user_id [String] the user UUID
    # @param body [Hash] the request body
    #
    # @return true
    #
    # @example
    #   session.users.add_roles(user_id, body)
    #
    def add_roles(user_id, body)
      response, status = BeyondAPI::Request.post(@session, "/users/#{user_id}/roles", body)

      handle_response(response, status, respond_with_true: true)
    end

    #
    # A +GET+ request is used to find a user by username.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/users/search/find-by-username?username=username' -i -X GET \
    #       -H 'Accept: application/hal+json' \
    #       -H 'Authorization: Bearer <Access token>'
    #
    # @beyond_api.scopes +user:r+
    #
    # @param username [String] the user username
    #
    # @return [OpenStruct]
    #
    # @example
    #   session.users.search_by_username(username)
    #
    def search_by_username(username)
      response, status = BeyondAPI::Request.get(@session, "/users/search/find-by-username", username: username)

      handle_response(response, status)
    end

    #
    # A +POST+ request is used to verify a password against the password guidelines.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/users/verify-password' -i -X POST \
    #       -H 'Content-Type: application/json' \
    #       -H 'Accept: application/json' \
    #       -d '{
    #     "password" : "ValidPassword!"
    #   }'
    #
    # @beyond_api.scopes ++
    #
    # @param password [String] the password to verify
    #
    # @return true
    #
    # @example
    #   session.users.verify_password(password)
    #
    def verify_password(password)
      response, status = BeyondAPI::Request.post(@session, "/users/verify-password", password: password)

      handle_response(response, status, respond_with_true: true)
    end

    #
    # A +POST+ request is used to change the password of a user.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/users/e112b1fe-5f67-4e22-a3c7-a1f6d1891b22/change-password' -i -X POST \
    #       -H 'Content-Type: application/json' \
    #       -H 'Accept: application/json' \
    #       -H 'Authorization: Bearer <Access token>' \
    #       -d '{
    #     "currentPassword" : "GoodPassword01!;)",
    #     "newPassword" : "ValidPassword123"
    #   }'
    #
    # @beyond_api.scopes ++
    #
    # @param user_id [String] the user UUID
    # @param current_password [String] the current password
    # @param new_password [String] the new password
    #
    # @return [OpenStruct]
    #
    # @example
    #   session.users.change_password(user_id, current_password, new_password)
    #
    def change_password(user_id, current_password, new_password)
      response, status = BeyondAPI::Request.post(@session, "/users/#{user_id}/change-password", current_password: current_password, new_password: new_password)

      handle_response(response, status)
    end

    #
    # A +POST+ request is used to trigger a password reset email to be sent to a user. The email will contain a link to the change password settings page of the merchant’s cockpit. The link includes a JWT to authorize the password reset.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/users/reset-password-request?locale=en-US' -i -X POST \
    #       -H 'Content-Type: application/json' \
    #       -H 'Accept: application/json' \
    #       -d '{
    #     "email" : "customer@host.tld"
    #   }'
    #
    # @beyond_api.scopes ++
    #
    # @param email [String] the user email
    # @param locale [String] the email locale
    #
    # @return true
    #
    # @example
    #   session.users.send_reset_password_email(email, locale)
    #
    def send_reset_password_email(email, locale)
      response, status = BeyondAPI::Request.post(@session, "/users/reset-password-request", { email: email }, { locale: locale })

      handle_response(response, status, respond_with_true: true)
    end

    #
    # A +POST+ request is used to change the username of a user.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/users/ea0ddc0b-e3fb-47c7-9133-e9f5fc0ec442/change-username' -i -X POST \
    #       -H 'Content-Type: application/json' \
    #       -H 'Accept: application/json' \
    #       -H 'Authorization: Bearer <Access token>' \
    #       -d '{
    #     "currentPassword" : "GoodPassword01!;)",
    #     "newUsername" : "new username"
    #   }'
    #
    # @beyond_api.scopes ++
    #
    # @param user_id [String] the user UUID
    # @param new_username [String] the new username
    # @param current_password [String] the current password
    #
    # @return [OpenStruct]
    #
    # @example
    #   session.users.change_username(user_id, new_username, current_password)
    #
    def change_username(user_id, new_username, current_password)
      response, status = BeyondAPI::Request.post(@session, "/users/#{user_id}/change-username", new_username: new_username, current_password: current_password)

      handle_response(response, status)
    end

    #
    # A +GET+ request is used to retrieve the status of the support access for a shop, i.e. if the support user is enabled or disabled for the shop.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/users/support' -i -X GET \
    #       -H 'Accept: application/hal+json' \
    #       -H 'Authorization: Bearer <Access token>'
    #
    # @beyond_api.scopes +user:r+
    #
    # @return [OpenStruct]
    #
    # @example
    #   session.users.support_access
    #
    def support_access
      response, status = BeyondAPI::Request.get(@session, "/users/support")

      handle_response(response, status)
    end

    #
    # A +POST+ request is used to enable support access for a shop. If enabled, the customer support will receive specific rights for direct support in the merchant’s cockpit.
    #
    # $ curl 'https://api-shop.beyondshop.cloud/api/users/support' -i -X POST \
    #     -H 'Content-Type: application/json' \
    #     -H 'Accept: application/json' \
    #     -H 'Authorization: Bearer <Access token>'
    #
    # @beyond_api.scopes +user:c+
    #
    # @return true
    #
    # @example
    #   session.users.enable_support_access
    #
    def enable_support_access
      response, status = BeyondAPI::Request.post(@session, "/users/support")

      handle_response(response, status, respond_with_true: true)
    end

    #
    # A +POST+ request is used to disable support access.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/users/support' -i -X DELETE \
    #       -H 'Content-Type: application/json' \
    #       -H 'Accept: application/json' \
    #       -H 'Authorization: Bearer <Access token>'
    #
    # @beyond_api.scopes +user:c+
    #
    # @return true
    #
    # @example
    #   session.users.disable_support_access
    #
    def disable_support_access
      response, status = BeyondAPI::Request.delete(@session, "/users/support")

      handle_response(response, status, respond_with_true: true)
    end

    #
    # A +POST+ request is used to trigger an email address change. A confirmation email to change the email address will be sent to the user. The confirmation email will contain a link to the email address change page of the merchant’s cockpit. The link includes a JWT to authorize the email address change.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/users/8f5fd817-0ea1-4550-b4b9-fc437b1b6905/change-email-request?locale=en-US' -i -X POST \
    #       -H 'Content-Type: application/json' \
    #       -H 'Accept: application/json' \
    #       -H 'Authorization: Bearer <Access token>' \
    #       -d '{
    #     "currentPassword" : "GoodPassword01!;)",
    #     "newEmail" : "newEmail@Gmail.com"
    #   }'
    #
    # @beyond_api.scopes ++
    #
    # @param user_id [String] the user UUID
    # @param new_email [String] the new email address
    # @param current_password [String] the current password
    # @param locale [String] the email locale
    #
    # @return true
    #
    # @example
    #   session.users.send_email_address_change(user_id, new_email, current_password, locale)
    #
    def send_email_address_change(user_id, new_email, current_password, locale)
      response, status = BeyondAPI::Request.post(@session, "/users/#{user_id}/change-email-request", { new_email: new_email, current_password: current_password }, { locale: locale })

      handle_response(response, status, respond_with_true: true)
    end
  end
end
