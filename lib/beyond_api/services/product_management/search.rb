# frozen_string_literal: true

module BeyondApi
  module ProductManagement
    # @example How to instantiate a client
    #   @client = BeyondApi::ProductManagement::Search.new(api_url: 'https://example.com/api', access_token: 'your_token')
    class Search < BaseService
      # Sarch for products by a search term. Optionally, you can also filter the search results.
      #
      # @see https://developer.epages.com/beyond-docs/#product-search-result
      #
      # @return [Hash]
      #
      # @example
      #   body = {
      #     search: { term: tag, category: 'TAGS' },
      #     filters: [{ key: 'status', values: ['DRAFT'] }],
      #     paging: { page: 0, pageSize: 100 }
      #   }
      #   @client.find(body)
      def find(body = {})
        post('products/search', body)
      end
    end
  end
end
