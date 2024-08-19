# frozen_string_literal: true

module BeyondApi
  module ProductManagement
    class Variation < BaseService
      def all(id, params = {})
        get("products/#{id}/variations", params)
      end
    end
  end
end
