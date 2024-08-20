# frozen_string_literal: true

module BeyondApi
  module Shop
    # @example How to instantiate a client
    #   @client = BeyondApi::Shop::Shop.new(api_url: 'https://example.com/api', access_token: 'your_token')
    class Shop < BaseService
      def show
        get('shop')
      end
    end
  end
end
