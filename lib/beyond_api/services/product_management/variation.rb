# frozen_string_literal: true

module BeyondApi
  module ProductManagement
    # @example How to instantiate a client
    #   @client = BeyondApi::ProductManagement::Variation.new(api_url: 'https://example.com/api', access_token: 'your_token')
    class Variation < BaseService
      # Retrieve the variations of a variation product in a paged manner.
      #
      # @see https://developer.epages.com/beyond-docs/#list_variations
      #
      # @param id [String] the product UUID
      # @option params [Boolean] :paginated
      # @option params [Integer] :size the page size
      # @option params [Integer] :page the page number
      #
      # @return [Hash]
      #
      # @example
      #   @client.all(size: 100, page: 0)
      def all(id, params = {})
        get("products/#{id}/variations", params)
      end

      # Update a variation partially with json content type.
      #
      # @see https://developer.epages.com/beyond-docs/#update_variation_partially_json
      #
      # @param id [String] the product UUID
      # @param variation_id [String] the variation UUID
      # @param body [Hash] the request body
      #
      # @return [Hash]
      #
      # @example
      #   variation = {
      #     sales_price: {
      #       tax_model: "GROSS",
      #       amount: 29.99,
      #       currency: "EUR"
      #     },
      #     list_price: {
      #       tax_model: "GROSS",
      #       amount: 39.99,
      #       currency: "EUR"
      #     },
      #     manufacturer_price: {
      #       tax_model: "GROSS",
      #       amount: 40.99,
      #       currency: "EUR"
      #     },
      #     sku: "1010"
      #   }
      #   @client.update('4125b993-49fc-47c8-b9b3-76d8871e4e06',
      #                  'a1b2c3d4-e5f6-7890-abcd-ef1234567890',
      #                  variation)
      #
      def update(id, variation_id, body)
        patch("products/#{id}/variations/#{variation_id}", body)
      end
    end
  end
end
