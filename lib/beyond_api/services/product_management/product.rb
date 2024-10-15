# frozen_string_literal: true

module BeyondApi
  module ProductManagement
    # @example How to instantiate a client
    #   @client = BeyondApi::ProductManagement::Product.new(api_url: 'https://example.com/api', access_token: 'your_token')
    class Product < BaseService
      # List all products in a paged manner.
      #
      # @see https://developer.epages.com/beyond-docs/#list_products
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
        fetch_all_pages('products', params)
      end

      # Create a product.
      #
      # @see https://developer.epages.com/beyond-docs/#create_product
      #
      # @param body [Hash] the request body
      #
      # @return [Hash]
      #
      # @example
      #   product_data = {
      #     sku: '123456789-001',
      #     name: 'Rioja Castillo de Puerto (2013)',
      #     description: 'Spain\nRioja Tempranillo',
      #     manufacturer: 'Grape Vineyard',
      #     essential_features: 'Dry. 12% alcohol. Best vine variety.',
      #     tags: ['Bestseller', 'Red Wine', 'Sale'],
      #     product_identifiers: [
      #       {
      #         type: 'EAN',
      #         value: '9780134308135'
      #       }
      #     ],
      #     sales_price: {
      #       tax_model: 'GROSS',
      #       amount: 8.7,
      #       currency: 'EUR'
      #     },
      #     list_price: {
      #       tax_model: 'GROSS',
      #       amount: 10.95,
      #       currency: 'EUR'
      #     },
      #     manufacturer_price: {
      #       tax_model: 'GROSS',
      #       amount: 11.95,
      #       currency: 'EUR'
      #     },
      #     visible: true,
      #     tax_class: 'REGULAR',
      #     shipping_weight: {
      #       value: 1175.0,
      #       display_unit: 'GRAMS'
      #     },
      #     max_order_quantity: 6,
      #     shipping_dimension: {
      #       length: 1500,
      #       width: 1000,
      #       height: 2000
      #     },
      #     ref_price: {
      #       ref_quantity: 1,
      #       unit: 'LITER',
      #       quantity: 0.75,
      #       price: {
      #         tax_model: 'GROSS',
      #         amount: 11.6,
      #         currency: 'EUR'
      #       }
      #     },
      #     shipping_period: {
      #       min: 2,
      #       max: 4,
      #       display_unit: 'WEEKS'
      #     },
      #     pickup_period: {
      #       min: 1,
      #       max: 2,
      #       display_unit: 'WEEKS'
      #     },
      #     product_labels: [
      #       {
      #         type: 'NEW',
      #         active_from: '2024-08-19T13:04:55.897122293',
      #         active_until: '2024-09-16T13:04:55.897122293'
      #       }
      #     ]
      #   }
      #   @client.create(product_data)
      def create(body)
        post('products', body)
      end

      # Retrieve the details of a product.
      #
      # @see https://developer.epages.com/beyond-docs/#show_product_details
      #
      # @param id [String] the product UUID
      #
      # @return [Hash]
      #
      # @example
      #   @client.find('985efde9-577c-4752-9556-af5ed8a81b1b')
      def find(id)
        get("products/#{id}")
      end
    end
  end
end
