module BeyondApi
  module ProductManagement
    class Product < BaseService
      def all(params = {})
        # BeyondApi::Request.get(@session, "/products", params)
        fetch_all_pages("/products", :products, params)
      end

      def find(id)
        BeyondApi::Request.get(@session, "/products/#{id}")
      end
    end
  end
end
