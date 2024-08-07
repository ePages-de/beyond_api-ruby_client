module BeyondApi
  module ProductManagement
    class Image < BaseService
      def all(id)
        Request.new(@session).get("/products/#{id}/images")
      end
    end
  end
end
