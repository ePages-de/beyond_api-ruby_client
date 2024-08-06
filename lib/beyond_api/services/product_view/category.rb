module BeyondApi
  module ProductView
    class Category < BaseService
      def all(params = {})
        BeyondApi::Request.get(@session, "/product-view/categories", params)
      end

      def find(id)
        BeyondApi::Request.get(@session, "/product-view/categories/#{id}")
      end

      def preview(filters)
        BeyondApi::Request.post(@session, "/product-view/categories/preview", filters:)
      end
    end
  end
end
