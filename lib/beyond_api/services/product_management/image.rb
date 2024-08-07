module BeyondApi
  module ProductManagement
    class Image < BaseService
      def all(id)
        get("products/#{id}/images")
      end
    end
  end
end
