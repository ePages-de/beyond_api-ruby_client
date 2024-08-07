module BeyondApi
  module ProductManagement
    class Category < BaseService
      def find(id)
        Request.new(@session).get("/categories/#{id}")
      end
    end
  end
end
