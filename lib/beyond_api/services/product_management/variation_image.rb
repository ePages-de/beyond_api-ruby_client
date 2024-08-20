# frozen_string_literal: true

module BeyondApi
  module ProductManagement
    # @example How to instantiate a client
    #   @client = BeyondApi::ProductManagement::VariationImage.new(api_url: 'https://example.com/api', access_token: 'your_token')
    class VariationImage < BaseService
      def all(product_id, variation_id, _params = {})
        get("products/#{product_id}/variations/#{variation_id}/images")
      end
    end
  end
end
