# frozen_string_literal: true

module BeyondApi
  module Shop
    # @example How to instantiate a client
    #   @client = BeyondApi::Shop::Shop.new(api_url: 'https://example.com/api', access_token: 'your_token')
    class Shop < BaseService
      # Retrieve the details of a shop.
      #
      # @see https://developer.epages.com/beyond-docs/#show_shop_details
      #
      # @return [Hash]
      #
      # @example
      #   @client.show
      def show
        get('shop')
      end
    end
  end
end
