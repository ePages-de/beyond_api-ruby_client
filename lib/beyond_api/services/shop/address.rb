# frozen_string_literal: true

module BeyondApi
  module Shop
    # @example How to instantiate a client
    #   @client = BeyondApi::Shop::Address.new(api_url: 'https://example.com/api', access_token: 'your_token')
    class Address < BaseService
      def show
        get('shop/address')
      end
    end
  end
end
