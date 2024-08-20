# frozen_string_literal: true

module BeyondApi
  module ProductManagement
    # @example How to instantiate a client
    #   @client = BeyondApi::ProductManagement::Variation.new(api_url: 'https://example.com/api', access_token: 'your_token')
    class Variation < BaseService
      def all(id, params = {})
        get("products/#{id}/variations", params)
      end
    end
  end
end
