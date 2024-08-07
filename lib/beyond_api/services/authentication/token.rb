module BeyondApi
  module Authentication
    class Token < BaseService
      def all(params = {})
        # fetch_all_pages("product-view/categories", :categories, params)
        get("product-view/categories", params)
      end

      def find(id)
        get("product-view/categories/#{id}")
      end

      def preview(body, params = {})
        post("product-view/categories/preview", body, params)
      end
    end
  end
end
