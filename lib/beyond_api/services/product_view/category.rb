module BeyondApi
  module ProductView
    class Category < BaseService
      def all(params = {})
        fetch_all_pages("product-view/categories", params)
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
