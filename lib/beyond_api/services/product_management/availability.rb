# frozen_string_literal: true

module BeyondApi
  module ProductManagement
    # @example How to instantiate a client
    #   @client = BeyondApi::ProductManagement::Availability.new(api_url: 'https://example.com/api', access_token: 'your_token')
    class Availability < BaseService
      # Retrieve the  the availability of a product.
      #
      # @see https://developer.epages.com/beyond-docs/#show_product_availability_details
      #
      # @param id [String] the product UUID
      #
      # @return [Hash]
      #
      # @example
      #   @client.availability('10edc7ed-2513-4228-adcd-54b32aae9300')
      def availability(id)
        get("products/#{id}/availability")
      end

      # Enable stock management for a product or variation product.
      #
      # @see https://developer.epages.com/beyond-docs/#enable_stock_management
      #
      # @param id [String] the product UUID
      # @param initial_available_stock [Integer] the number of products available in stock
      # @param stock_threshold [Integer] the inventory level that indicates that the product needs to be reordered
      #
      # @return [Hash]
      #
      # @example
      #   @client.enable_stock_management('b5545f71-0895-46e2-bc2b-b40adc8d1b3e', 100, 2)
      def enable_stock_management(id, initial_available_stock, stock_threshold)
        post("products/#{id}/availability/enable-stock-management",
             { initial_available_stock:, stock_threshold: })
      end

      # Disable stock management for a product or variation product.
      #
      # @see https://developer.epages.com/beyond-docs/#disable_stock_management
      #
      # @param id [String] the product UUID
      #
      # @return [Hash]
      #
      # @example
      #   @client.disable_stock_management('0305a6f7-8c71-4420-80e0-7509636d8f19')
      def disable_stock_management(id)
        post("products/#{id}/availability/disable-stock-management")
      end

      # Adjust the available stock of a product.
      #
      # @see https://developer.epages.com/beyond-docs/#adjust_stock_level
      #
      # @param id [String] the product UUID
      # @param relative_amount [Integer] the relative amount to change the number of products available in stock by
      #
      # @return [Hash]
      #
      # @example
      #   @client.adjust_stock_level('5ab890e6-55ec-43d0-a9ba-c1d28bbe08e0', -1)
      def adjust_stock_level(id, relative_amount)
        post("products/#{id}/availability/adjust-available-stock", relative_amount:)
      end

      # Update this reserve stock by changing the stockThreshold value of a product or variation product.
      #
      # @see https://developer.epages.com/beyond-docs/#update_reserve_stock
      #
      # @param id [String] the product UUID
      # @param stock_threshold [Integer] the inventory level that indicates that the product needs to be reordered
      #
      # @return [Hash]
      #
      # @example
      #   @client.update_reserve_stock('341a50d4-580c-4c69-8529-48880d44709f', -1)
      def update_reserve_stock(id, stock_threshold)
        put("products/#{id}/availability/update-stock-threshold", stock_threshold:)
      end

      # Enable purchasability for a product.
      #
      # @see https://developer.epages.com/beyond-docs/#enable_purchasability
      #
      # @param id [String] the product UUID
      #
      # @return [Hash]
      #
      # @example
      #   @client.enable_purchasability('30c41901-f2b0-4598-be9f-9f50fbed989c')
      def enable_purchasability(id)
        post("products/#{id}/availability/enable-purchasability")
      end

      # Disable purchasability for a product.
      #
      # @see https://developer.epages.com/beyond-docs/#disable_purchasability
      #
      # @param id [String] the product UUID
      #
      # @return [Hash]
      #
      # @example
      #   @client.disable_purchasability('5723118a-7e52-4c73-8f4d-3cc044342064')
      def disable_purchasability(id)
        post("products/#{id}/availability/disable-purchasability")
      end

      # Retrieve the availability of a variation of a variation product.
      #
      # @see https://developer.epages.com/beyond-docs/#show_variation_availability_details
      #
      # @param product_id [String] the product UUID
      # @param variation_id [String] the variation UUID
      #
      # @return [Hash]
      #
      # @example
      #   @client.variation_availability('4125b993-49fc-47c8-b9b3-76d8871e4e06',
      #                                   'a1b2c3d4-e5f6-7890-abcd-ef1234567890')
      def variation_availability(product_id, variation_id)
        get("products/#{product_id}/variations/#{variation_id}/availability")
      end

      # Adjust the available stock of a variation.
      #
      # @see https://developer.epages.com/beyond-docs/#adjust_variation_stock_level
      #
      # @param product_id [String] the product UUID
      # @param variation_id [String] the variation UUID
      # @param relative_amount [Integer] the relative amount to change the available stock by
      #
      # @return [Hash]
      #
      # @example
      #   @client.adjust_variation_stock_level('4125b993-49fc-47c8-b9b3-76d8871e4e06',
      #                                        'a1b2c3d4-e5f6-7890-abcd-ef1234567890', -1)
      def adjust_variation_stock_level(product_id, variation_id, relative_amount)
        post("products/#{product_id}/variations/#{variation_id}/availability/adjust-available-stock",
             relative_amount:)
      end
    end
  end
end
