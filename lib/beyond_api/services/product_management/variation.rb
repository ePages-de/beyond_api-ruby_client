module BeyondApi
  module ProductManagement
    class Variation < BaseService
      def all(id)
        Request.get(@session, "/products/#{id}/variations")
      end
    end
  end
end
