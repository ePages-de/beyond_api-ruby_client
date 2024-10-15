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
        super("webhook-subscriptions/#{id}")
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

      # Activate a webhook subscription. You might want to use this request for a deactivated webhook.
      #
      # @see https://developer.epages.com/beyond-docs/#activate_webhook_subscription
      #
      # @param id [String] the webhook subscription UUID
      #
      # @return [Hash]
      #
      # @example
      #   @client.activate('1d61c1b4-49aa-4827-bd04-b1c4374f3499')
      def activate(id)
        post("webhook-subscriptions/#{id}/activate")
      end

      # Deactivate a webhook subscription. You might want to use this request for a currently active webhook.
      #
      # @see https://developer.epages.com/beyond-docs/#deactivate_webhook_subscription
      #
      # @param id [String] the webhook subscription UUID
      #
      # @return [Hash]
      #
      # @example
      #   @client.deactivate('8517ab39-db0e-417a-87ed-f96e437c03e4')
      def deactivate(id)
        post("webhook-subscriptions/#{id}/deactivate")
      end

      # List all failed deliveries of a webhook subscription in a paged way.
      #
      # @see https://developer.epages.com/beyond-docs/#list_failed_webhook_deliveries
      #
      # @param id [String] the webhook subscription UUID
      # @option params [Boolean] :paginated
      # @option params [Integer] :size the page size
      # @option params [Integer] :page the page number
      #
      # @return [Hash]
      #
      # @example
      #   @client.failures('a3dd55a4-dbc3-4f20-8a5e-d0fe4ba59afd', { size: 100, page: 0 })
      def failures(id, params = {})
        fetch_all_pages("webhook-subscriptions/#{id}/failures", params)
      end

      # Retry a failed webhook delivery.
      #
      # @see https://developer.epages.com/beyond-docs/#retry_failed_webhook_delivery
      #
      # @param webhook_id [String] the webhook subscription UUID
      # @param failure_id [String] the failure UUID
      #
      # @return [Hash]
      #
      # @example
      #   @client.retry('d9828fba-3922-4750-a70c-174daeeb37e4',
      #                 'b21146e0-16b9-468f-806b-a23c8e04a7fc')
      def retry(webhook_id, failure_id)
        post("webhook-subscriptions/#{webhook_id}/failures/#{failure_id}/retry")
      end

      # Delete a webhook failure.
      #
      # @see https://developer.epages.com/beyond-docs/#delete_webhook_delivery_failure
      #
      # @param webhook_id [String] the webhook subscription UUID
      # @param failure_id [String] the failure UUID
      #
      # @return [Hash] an empty hash
      #
      # @example
      #   @client.delete_failure('cbcebfc4-9dee-4344-83b2-8c25b2287a60',
      #                          'f090610b-19da-4e40-a986-3c9562fefeab')
      def delete_failure(webhook_id, failure_id)
        delete("webhook-subscriptions/#{webhook_id}/failures/#{failure_id}")
      end
    end
  end
end
