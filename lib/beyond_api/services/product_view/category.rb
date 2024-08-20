# frozen_string_literal: true

module BeyondApi
  module ProductView
    # @example How to instantiate a client
    #   @client = BeyondApi::ProductView::Category.new(api_url: 'https://example.com/api', access_token: 'your_token')
    class Category < BaseService
      def all(params = {})
        fetch_all_pages('product-view/categories', params)
      end

      def find(id)
        get("product-view/categories/#{id}")
      end

      def preview(body, params = {})
        post('product-view/categories/preview', body, params)
      end
    end
  end
end
