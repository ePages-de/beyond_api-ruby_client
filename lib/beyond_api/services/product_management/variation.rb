module BeyondApi
  module ProductManagement
    class Variation < BaseService
      def all(id, params = {})
        get("products/#{id}/variations")
      end
    end
  end
end
