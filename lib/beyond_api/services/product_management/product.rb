module BeyondApi
  module ProductManagement
    class Product < BaseService
      def all(params = {})
        fetch_all_pages("products", params)
      end

      def create(body)
        post("products", body)
      end

      def find(id)
        get("products/#{id}")
      end
    end
  end
end
