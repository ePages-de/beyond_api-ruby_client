module BeyondApi
  module Webhook
    class Subscription < BaseService
      def all(params = {})
        get("webhook-subscriptions", params)
      end

      def create(body)
        post("webhook-subscriptions", body)
      end

      def delete_all
        all.dig(:embedded, :subscriptions).each do |subscription|
          destroy(subscription[:id])
        end
      end

      def delete(id)
        Connection.delete("webhook-subscriptions/#{id}")
      end

      def find(id)
        get("webhook-subscriptions/#{id}")
      end
    end
  end
end
