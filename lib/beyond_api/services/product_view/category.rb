module BeyondApi
  module ProductView
    class Category < BaseService
      def all(params = {})
        fetch_all_pages("/product-view/categories", :categories, params)
      end

      def find(id)
        BeyondApi::Request.get(@session, "/product-view/categories/#{id}")
      end

      def preview(body, params = {})
        BeyondApi::Request.post(@session,
                                "/product-view/categories/preview",
                                body,
                                params)
      end
    end
  end
end
