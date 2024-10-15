# frozen_string_literal: true

module BeyondApi
  module Checkout
    # @example How to instantiate a client
    #   @client = BeyondApi::Checkout::ShippingZone.new(api_url: 'https://example.com/api', access_token: 'your_token')
    class ShippingZone < BaseService
      # List all shipping zones in a paged way.
      #
      # @see https://developer.epages.com/beyond-docs/#list_shipping_zones
      #
      # @option params [Boolean] :paginated
      # @option params [Integer] :size the page size
      # @option params [Integer] :page the page number
      #
      # @return [Hash]
      #
      # @example
      #   @client.all(size: 100, page: 0)
      def all(params = {})
        fetch_all_pages('shipping-zones', params)
      end
    end
  end
end
