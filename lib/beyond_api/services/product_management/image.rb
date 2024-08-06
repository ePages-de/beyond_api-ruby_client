module BeyondApi
  module ProductManagement
    class Image < BaseService
      def all(id)
        BeyondApi::Request.get(@session, "/products/#{id}/images")
      end
    end
  end
end
