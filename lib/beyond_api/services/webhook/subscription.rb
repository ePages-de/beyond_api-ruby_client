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
      #   webhook_data = {
      #     callback_uri: 'http://example.com/test',
      #     event_types: ['order.created', 'product.created']
      #   }
      #   @client.create(webhook_data)
      def create(body)
        post('webhook-subscriptions', body)
      end

      # Delete all webhook subscriptions.
      #
      # @param body [Hash] the request body
      #
      # @return [Hash]
      #
      # @example
      #   @client.delete_all
      def delete_all
        all.dig(:embedded, :subscriptions).each do |subscription|
          delete(subscription[:id])
        end
      end

      # Delete a webhook subscription.
      #
      # @see https://developer.epages.com/beyond-docs/#delete_webhook_subscription
      #
      # @param id [String] the webhook subscription UUID
      #
      # @return [Hash] an empty hash
      #
      # @example
      #   @client.delete('84ce4b3a-9a10-46d0-afcd-a71bcd0c0e9a')
      def delete(id)
        super("webhook-subscriptions/#{id}") # Concerns::Connection delete method
      end

      # Retrieve the details of a webhook subscription.
      #
      # @see https://developer.epages.com/beyond-docs/#show_webhook_subscription_details
      #
      # @param id [String] the webhook subscription UUID
      #
      # @return [Hash]
      #
      # @example
      #   @client.find('a2e39f0f-7728-40ca-88e4-cb8cea9ecf5e')
      def find(id)
        get("webhook-subscriptions/#{id}")
      end
    end
  end
end
