module BeyondApi
  module ProductView
    class Category < BaseService
      def find(id)
        response = BeyondApi::Request.get(@session,
                                          "/product-view/categories/#{id}")

        response
      end
    end
  end
end
