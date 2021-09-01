# frozen_string_literal: true

require "beyond_api/utils"

module BeyondApi
  class WebhookSubscriptions < Base
    include BeyondApi::Utils

    #
    # A +POST+ request is used to activate a webhook subscription.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/webhook-subscriptions/268a8629-55cd-4890-9013-936b9b5ea14c/activate' -i -X POST \
    #       -H 'Authorization: Bearer <Access token>'
    #
    # @beyond_api.scopes +ordr:r+, +prod:r+
    #
    # @param webhook_subscription_id [String] the webhook subscription UUID
    #
    # @return true
    #
    # @example Ruby example request
    #   session.webhook_subscriptions.activate("268a8629-55cd-4890-9013-936b9b5ea14c")
    #
    def activate(webhook_subscription_id)
      response, status = BeyondApi::Request.post(@session, "/webhook-subscriptions/#{webhook_subscription_id}/activate")

      handle_response(response, status, respond_with_true: true)
    end

    #
    # A +GET+ request is used to list all of the webhook subscriptions in a paged way.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/webhook-subscriptions' -i -X GET \
    #       -H 'Accept: application/hal+json' \
    #       -H 'Authorization: Bearer <Access token>'
    #
    # @option params [Boolean] :paginated
    # @option params [Integer] :size the page size
    # @option params [Integer] :page the page number
    #
    # @return [OpenStruct]
    #
    # @example
    #   @webhook_subscriptions = session.webhook_subscriptions.all(size: 100, page: 0)
    #
    def all(params = {})
      handle_all_request("/webhook-subscriptions", :webhook_subscriptions, params)
    end

    #
    # A +POST+ request is used to create a webhook subscription.
    #
    # The scopes needed for the operation depend on the event types you register for. e.g. Order events require the scope +orde:r+.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/webhook-subscriptions' -i -X POST \
    #       -H 'Content-Type: application/json' \
    #       -H 'Accept: application/hal+json' \
    #       -H 'Authorization: Bearer <Access token>' \
    #       -d '{
    #       "callbackUri":"http://example.com/test",
    #       "eventTypes": ["order.created", "product.created"]
    #   }'
    #
    # @param body [Hash] the request body
    #
    # @return [OpenStruct]
    #
    # @example
    #   body = {
    #     "callback_uri" => "http://example.com/test",
    #     "event_types" => ["order.created", "product.created"]
    #   }
    #
    #   @webhook_subscription = session.webhook_subscriptions.create(body)
    #
    def create(body)
      response, status = BeyondApi::Request.post(@session, "/webhook-subscriptions", body)

      handle_response(response, status)
    end

    #
    # A +POST+ request is used to deactivate a webhook subscription.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/webhook-subscriptions/a597cea4-b688-4164-8c56-b6568ea4d5aa/deactivate' -i -X POST \
    #       -H 'Authorization: Bearer <Access token>'
    #
    # @param webhook_subscription_id [String] the webhook subscription UUID
    #
    # @return true
    #
    # @example
    #   session.webhook_subscriptions.deactivate("a597cea4-b688-4164-8c56-b6568ea4d5aa")
    #
    def deactivate(webhook_subscription_id)
      response, status = BeyondApi::Request.post(@session, "/webhook-subscriptions/#{webhook_subscription_id}/deactivate")

      handle_response(response, status, respond_with_true: true)
    end

    #
    # A +DELETE+ request is used to delete a webhook subscription.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/webhook-subscriptions/c6076a5a-a8ad-443f-b20b-8a1b268b069e' -i -X DELETE \
    #       -H 'Authorization: Bearer <Access token>'
    #
    # @param webhook_subscription_id [String] the webhook subscription UUID
    #
    # @return true
    #
    # @example
    #   session.webhook_subscriptions.delete("c6076a5a-a8ad-443f-b20b-8a1b268b069e")
    #
    def delete(webhook_subscription_id)
      response, status = BeyondApi::Request.delete(@session, "/webhook-subscriptions/#{webhook_subscription_id}")

      handle_response(response, status, respond_with_true: true)
    end

    #
    # A +GET+ request is used to retrieve the details of a webook subscription.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/webhook-subscriptions/3d44ec71-768c-4927-9069-a96a5153e87c' -i -X GET \
    #       -H 'Accept: application/hal+json' \
    #       -H 'Authorization: Bearer <Access token>'
    #
    # @param webhook_subscription_id [String] the webhook subscription UUID
    #
    # @return [OpenStruct]
    #
    # @example
    #   @webhook_subscription = session.webhook_subscriptions.find("3d44ec71-768c-4927-9069-a96a5153e87c")
    #
    def find(webhook_subscription_id)
      response, status = BeyondApi::Request.get(@session, "/webhook-subscriptions/#{webhook_subscription_id}")

      handle_response(response, status)
    end

    #
    # A +PUT+ request is used to update a subscription.
    #
    # The scopes needed for the operation depend on the event types you register for. e.g. Order events require the scope +orde:r+.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/webhook-subscriptions/6f3bc033-c2d1-4f44-80e3-1b668f6bd699' -i -X PUT \
    #       -H 'Content-Type: application/json' \
    #       -H 'Accept: application/hal+json' \
    #       -H 'Authorization: Bearer <Access token>' \
    #       -d '{
    #       "callbackUri":"http://example.com/test/updated",
    #       "eventTypes": ["product.updated"]
    #   }'
    #
    # @beyond_api.scopes +ordr:r+, +prod:r+
    #
    # @param webhook_subscription_id [String] the webhook subscription UUID
    # @param body [Hash] the request body
    #
    # @return [OpenStruct]
    #
    # @example
    #   body = {
    #     "callback_uri" => "http://example.com/test/updated",
    #     "event_types" => ["product.updated"]
    #   }
    #
    #   @webhook_subscription = session.webhook_subscriptions.update("6f3bc033-c2d1-4f44-80e3-1b668f6bd699", body)
    #
    def update(webhook_subscription_id, body)
      response, status = BeyondApi::Request.put(@session, "/webhook-subscriptions/#{webhook_subscription_id}", body)

      handle_response(response, status)
    end
  end
end
