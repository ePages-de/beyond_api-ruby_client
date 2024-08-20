# frozen_string_literal: true

module BeyondApi
  module ProductManagement
    # @example How to instantiate a client
    #   @client = BeyondApi::ProductManagement::Image.new(api_url: 'https://example.com/api', access_token: 'your_token')
    class Image < BaseService
      # Retrieve the images of a product.
      #
      # @see https://developer.epages.com/beyond-docs/#list_product_images
      #
      # @option params [Integer] :size the page size
      # @option params [Integer] :page the page number
      #
      # @return [Hash]
      #
      # @example
      #   @client.all(size: 100, page: 0)
      def all(id, params = {})
        get("products/#{id}/images", params)
      end
    end
  end
end
