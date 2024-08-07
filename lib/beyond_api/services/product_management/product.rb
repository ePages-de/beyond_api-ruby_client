module BeyondApi
  module ProductManagement
    class Product < BaseService
      def all(params = {})
        # Request.new(@session).get("/products", params)
        fetch_all_pages("/products", :products, params)
      end

      def find(id)
        Request.new(@session).get("/products/#{id}")
      end
    end
  end
end
