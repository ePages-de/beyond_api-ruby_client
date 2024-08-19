module BeyondApi
  module ProductManagement
    class Image < BaseService
      def all(id, params = {})
        get("products/#{id}/images", params)
      end
    end
  end
end
