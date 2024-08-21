# frozen_string_literal: true

module BeyondApi
  module ProductView
    # @example How to instantiate a client
    #   @client = BeyondApi::ProductView::Category.new(api_url: 'https://example.com/api', access_token: 'your_token')
    class Category < BaseService
      # List all product categories in a paged manner.
      #
      # @see https://developer.epages.com/beyond-docs/#list_product_categories
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
        fetch_all_pages('product-view/categories', params)
      end

      # Retrieve the details of a category.
      #
      # @see https://developer.epages.com/beyond-docs/#show_product_category_details
      #
      # @param id [String] the category UUID
      #
      # @return [Hash]
      #
      # @example
      #   @client.find('823c12ed-1f1b-47c6-8fc8-51fb7338be84')
      def find(id)
        get("product-view/categories/#{id}")
      end

      # Preview products included in category in a paged manner.
      #
      # @see https://developer.epages.com/beyond-docs/#preview_products_included_in_category
      #
      # @param body [Hash] the product filters
      # @option params [Boolean] :paginated
      # @option params [Integer] :size the page size
      # @option params [Integer] :page the page number
      #
      # @return [Hash]
      #
      # @example
      #   body = {
      #     filters: [
      #       {
      #         key: "manufacturer",
      #         values: ["Grape Vineyard"]
      #       },
      #       {
      #         key: "all_tags",
      #         values: ["Power Bar", "Bestseller", "High Protein"]
      #       },
      #       {
      #         key: "price_range",
      #         min: 3.7,
      #         max: 13.7
      #       }
      #     ]
      #   }
      #   @client.preview(body, { size: 100, page: 0 })
      def preview(body, params = {})
        post('product-view/categories/preview', body, params)
      end
    end
  end
end
