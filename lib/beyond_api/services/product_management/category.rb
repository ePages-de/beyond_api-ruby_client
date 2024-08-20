# frozen_string_literal: true

module BeyondApi
  module ProductManagement
    # @example How to instantiate a client
    #   @client = BeyondApi::ProductManagement::Category.new(api_url: 'https://example.com/api', access_token: 'your_token')
    class Category < BaseService
      # Retrieve the details of a category.
      #
      # @param id [String] the category UUID
      #
      # @return [Hash]
      #
      # @see https://developer.epages.com/beyond-docs/#show_category_details
      #
      # @example
      #   @client.find('e97226a6-9412-481f-b1d7-e64fc58df88e')
      def find(id)
        get("categories/#{id}")
      end

      # List all available categories in a paged manner.
      #
      # @option params [Boolean] :paginated
      # @option params [Integer] :size the page size
      # @option params [Integer] :page the page number
      #
      # @return [Hash]
      #
      # @see https://developer.epages.com/beyond-docs/#list_categories
      #
      # @example
      #   @client.all(size: 100, page: 0)
      def all(params = {})
        fetch_all_pages('categories', params)
      end

      # Create a product category.
      #
      # @see https://developer.epages.com/beyond-docs/#create_category
      #
      # @param body [Hash] the request body
      #
      # @return [Hash]
      #
      # @example
      #   @client.create(name: 'Power Bars', type: 'SMART', default_sort: 'NEWEST_FIRST')
      def create(body)
        post('categories', body)
      end

      # Update all product category properties.
      #
      # @param body [Hash] the request body
      #
      # @return [Hash]
      #
      # @see https://developer.epages.com/beyond-docs/#update_all_category_properties
      #
      # @example
      #   @client.update(name: 'High Protein Power Bars', type: 'SMART', default_sort: 'NEWEST_FIRST')
      def update(id, body)
        put("categories/#{id}", body)
      end

      # Delete a product category.
      #
      # @param id [String] the category UUID
      #
      # @return [Hash] an empty hash
      #
      # @see https://developer.epages.com/beyond-docs/#list_categories
      #
      # @example
      #   @client.delete('c8cc52ec-fe57-4d4d-a2e3-f1756e767724')
      def delete(id)
        super("categories/#{id}") # Concerns::Connection delete method
      end
    end
  end
end
