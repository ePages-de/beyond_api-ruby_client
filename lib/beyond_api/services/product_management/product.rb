module BeyondApi
  module ProductManagement
    class Product < BaseService
      def all(params = {})
        # Request.new(@session).get("products", params)
        # fetch_all_pages("/products", :products, params)
        get("products", params)
      end

      def find(id)
        get("products/#{id}")
      end
    end
  end
end
