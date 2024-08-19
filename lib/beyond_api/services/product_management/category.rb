module BeyondApi
  module ProductManagement
    class Category < BaseService
      def find(id)
        get("categories/#{id}")
      end
    end
  end
end
