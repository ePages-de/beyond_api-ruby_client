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
    end
  end
end
