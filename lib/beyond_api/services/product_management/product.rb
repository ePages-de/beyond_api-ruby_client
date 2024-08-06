module BeyondApi
  module ProductManagement
    class Product < BaseService
      def find(id)
        BeyondApi::Request.get(@session, "/products/#{id}")
      end
    end
  end
end
