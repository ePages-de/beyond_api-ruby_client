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

      # List products including variation products in a paged manner.
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
      #   @client.all_with_variations(size: 20, page: 1)
      def all_with_variations(params = {})
        fetch_all_pages('products', params)
      end

      # Create a variation product.
      #
      # @see https://developer.epages.com/beyond-docs/#create_variation_product
      #
      # @param body [Hash] the request body containing variation product details
      #
      # @return [Hash]
      #
      # @example
      #   variation_product_data = {
      #     sales_price: {
      #       tax_model: 'GROSS',
      #       currency: 'EUR',
      #       amount: 29.99
      #     },
      #     list_price: {
      #       tax_model: 'GROSS',
      #       currency: 'EUR',
      #       amount: 39.99
      #     },
      #     manufacturer_price: {
      #       tax_model: 'GROSS',
      #       currency: 'EUR',
      #       amount: 40.99
      #     },
      #     tags: ['Shirt', 'Summer', 'Sale'],
      #     product_identifiers: [],
      #     visible: true,
      #     tax_class: 'REGULAR',
      #     shipping_weight: {
      #       value: 100.0,
      #       display_unit: 'GRAMS'
      #     },
      #     max_order_quantity: nil,
      #     shipping_dimension: {
      #       length: 2000,
      #       width: 750,
      #       height: 500
      #     },
      #     ref_price: nil,
      #     shipping_period: {
      #       min: 3,
      #       max: 5,
      #       display_unit: 'DAYS'
      #     },
      #     pickup_period: {
      #       min: 1,
      #       max: 3,
      #       display_unit: 'DAYS'
      #     },
      #     name: 'Tony Highfinger, Poloshirt, Men',
      #     description: '100% cotton, regular fit, needs cold washing (max. 30°C), Fair Trade certified.',
      #     manufacturer: 'Tony Highfinger',
      #     essential_features: nil,
      #     custom_text: nil,
      #     variation_attributes: [
      #       {
      #         display_name: 'size',
      #         values: ['S', 'M', 'L', 'XL']
      #       },
      #       {
      #         display_name: 'color',
      #         values: ['Black', 'White', 'Grey']
      #       }
      #     ],
      #     product_labels: [
      #       {
      #         type: 'NEW',
      #         active_from: '2024-10-29T12:52:02.121878416',
      #         active_until: '2024-11-26T12:52:02.121878416'
      #       }
      #     ]
      #   }
      #   @client.create(variation_product_data)
      def create_variation(body)
        post('products', body)
      end

      # Retrieve the details of a variation product.
      #
      # @see https://developer.epages.com/beyond-docs/#show_variation_product_details
      #
      # @param id [String] the variation product UUID
      #
      # @return [Hash]
      #
      # @example
      #   @client.find_variation('097ed6ba-0a39-4c75-936f-7e334ed4f110')
      def find_variation(id)
        get("products/#{id}")
      end

      # Update a product partially.
      #
      # @see https://developer.epages.com/beyond-docs/#update_product_partially
      #
      # @param id [String] the product UUID
      # @param body [Hash] the request body containing fields to update
      #
      # @return [Hash]
      #
      # @example
      #   update_data = {
      #     name: 'Castillo de Alba Rioja (2013)',
      #     description: 'Spain\nRioja',
      #     manufacturer: 'Mantecillia'
      #   }
      #   @client.update_product('da296052-1bc2-439a-9eb9-bf7782f55e81', update_data)
      def update_product(id, body)
        patch("products/#{id}", body)
      end

      # Update multiple products partially (Currently, this endpoint can only be used to update the visible property).
      #
      # @see https://developer.epages.com/beyond-docs/#update_multiple_products_partially
      #
      # @param ids [Array<String>] the IDs of the products to update
      # @param visible [Boolean] visibility status to apply to all products
      #
      # @return [Hash]
      #
      # @example
      #   @client.update_products_visibility(['a32ef424-ecc4-4bfc-815b-4f15bb3cffa1', 'a98292eb-0c64-459b-b28d-e229013b86b7'], true)
      def update_products_visibility(ids, visible)
        body = {
          ids:,
          details: {
            visible:
          }
        }
        patch('products/batch', body)
      end

      # Update a variation product partially.
      #
      # @see https://developer.epages.com/beyond-docs/#update_variation_product_partially
      #
      # @param id [String] the UUID of the variation product
      # @param body [Hash] the request body with fields to update
      #
      # @return [Hash]
      #
      # @example
      #   variation_update_data = {
      #     name: 'Rioja Castillo de Puerto (2013)',
      #     description: 'Spain\nRioja Tempranillo',
      #     variationAttributes: [
      #       {
      #         displayName: 'Width',
      #         values: ['100', '150'],
      #         variationImagesDifferentiator: false
      #       }
      #     ],
      #     manufacturer: 'Grape Vineyard',
      #     salesPrice: {
      #       taxModel: 'GROSS',
      #       currency: 'EUR',
      #       amount: 8.7
      #     }
      #   }
      #   @client.update_variation_product('e0c285ad-d728-475a-974e-cd5360ceeb4f', variation_update_data)
      def update_variation_product(id, body)
        patch("products/#{id}", body)
      end

      # Delete a product or variation product.
      #
      # @see https://developer.epages.com/beyond-docs/#delete_product
      #
      # @param id [String] the UUID of the product to delete
      #
      # @return [nil]
      #
      # @example
      #   @client.delete_product('4f8c204e-b56e-4e10-93b5-24ac56df2db0')
      def delete_product(id)
        delete("products/#{id}")
      end

      # Delete multiple products or variation products.
      #
      # @see https://developer.epages.com/beyond-docs/#delete_multiple_products
      #
      # @param ids [Array<String>] the IDs of the products to delete
      #
      # @return [nil]
      #
      # @example
      #   @client.delete_multiple_products(['e6f1d2ef-df46-4d99-bbca-550971b51c17', 'b9fcf3d7-4e76-4818-9f48-2ce43929d35b'])
      def delete_multiple_products(ids)
        body = { ids: }
        delete('products/batch', {}, body)
      end

      # Add tags to multiple products.
      #
      # @see https://developer.epages.com/beyond-docs/#add_tags_to_products
      #
      # @param ids [Array<String>] the IDs of the products to tag
      # @param tags [Array<String>] the tags to assign
      #
      # @return [nil]
      #
      # @example
      #   @client.add_tags_to_products(['4982d1fc-8822-4e0a-bc2d-d4d3cdbaf0f4', '63a94256-55b2-4564-b24d-ba65e27d4e07'], ['Sale', 'Wine', 'Bestseller'])
      def add_tags_to_products(ids, tags)
        body = {
          ids:,
          details: {
            tags:
          }
        }
        post('products/batch/tags', body)
      end

      # Remove tags from multiple products.
      #
      # @see https://developer.epages.com/beyond-docs/#remove_tags_from_products
      #
      # @param ids [Array<String>] the IDs of the products from which to remove tags
      # @param tags [Array<String>] the tags to remove
      #
      # @return [nil]
      #
      # @example
      #   @client.remove_tags_from_products(['af834a09-67a2-4397-bad8-262793504b70', 'd0c1ca27-0a5a-48d0-b215-14c7a713c4ab'], ['Sale', 'Wine', 'Bestseller'])
      def remove_tags_from_products(ids, tags)
        body = {
          ids:,
          details: {
            tags:
          }
        }
        delete('products/batch/tags', {}, body)
      end
    end
  end
end
