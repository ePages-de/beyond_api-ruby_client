module BeyondApi
  module ProductManagement
    class Variation < BaseService
      def all(id)
        Request.new(@session).get("/products/#{id}/variations")
      end
    end
  end
end
