module BeyondApi
  module ProductView
    class Category < BaseService
      def all(params = {})
        BeyondApi::Request.get(@session, "/product-view/categories", params)
      end

      def find(id)
        BeyondApi::Request.get(@session, "/product-view/categories/#{id}")
      end
    end
  end
end
