module BeyondApi
  module ProductManagement
    class Product < BaseService
      def all(params = {})
        # BeyondApi::Request.get(@session, "/products", params)
        handle_all_request("/products", :products, params)
      end

      def find(id)
        BeyondApi::Request.get(@session, "/products/#{id}")
      end
    end
  end
end
