# frozen_string_literal: true

module BeyondApi
  module ProductManagement
    # @example How to instantiate a client
    #   @client = BeyondApi::ProductManagement::Product.new(api_url: 'https://example.com/api', access_token: 'your_token')
    class Product < BaseService
      def all(params = {})
        fetch_all_pages('products', params)
      end

      def create(body)
        post('products', body)
      end

      def find(id)
        get("products/#{id}")
      end
    end
  end
end
