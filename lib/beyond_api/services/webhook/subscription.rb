# frozen_string_literal: true

module BeyondApi
  module Webhook
    # @example How to instantiate a client
    #   @client = BeyondApi::Webhook::Subscription.new(api_url: 'https://example.com/api', access_token: 'your_token')
    class Subscription < BaseService
      # List all webhooks subscriptions in a paged manner.
      #
      # @see https://developer.epages.com/beyond-docs/#list_webhook_subscriptions
      #
      # @option params [Integer] :size the page size
      # @option params [Integer] :page the page number
      #
      # @return [Hash]
      #
      # @example
      #   @client.all(size: 100, page: 0)
      def all(params = {})
        get('webhook-subscriptions', params)
      end

      # Create a webhook subscription.
      #
      # @see https://developer.epages.com/beyond-docs/#create_webhook_subscription
      #
      # @param body [Hash] the request body
      #
      # @return [Hash]
      #
      # @example
      #   @client.create(callback_uri: "http://example.com/test", "event_types": ["order.created", "product.created"])
      def create(body)
        post('webhook-subscriptions', body)
      end

      def delete_all
        all.dig(:embedded, :subscriptions).each do |subscription|
          delete(subscription[:id])
        end
      end

      def delete(id)
        super("webhook-subscriptions/#{id}") # Concerns::Connection delete method
      end

      def find(id)
        get("webhook-subscriptions/#{id}")
      end
    end
  end
end
