# frozen_string_literal: true

module BeyondApi
  module Shop
    # @example How to instantiate a client
    #   @client = BeyondApi::Shop::Feature.new(api_url: 'https://example.com/api', access_token: 'your_token')
    class Feature < BaseService
      # List all features that are assigned to a specific shop identified by the current hostname.
      #
      # @see https://developer.epages.com/beyond-docs/#list_feature_assignments
      #
      # @return [Hash]
      #
      # @example
      #   @client.all
      def all
        get('shop/features')
      end

      # Retrieve the details of a specific feature assignment of a merchant’s shop identified by the current hostname.
      #
      # @see https://developer.epages.com/beyond-docs/#show_feature_assignment_details
      #
      # @param feature_name [String] The feature name
      #
      # @return [Hash]
      #
      # @example
      #   @client.find('product-management.max-products')
      def find(feature_name)
        get("shop/features/#{feature_name}")
      end
    end
  end
end
