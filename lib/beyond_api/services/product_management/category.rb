module BeyondApi
  module ProductManagement
    class Category < BaseService
      def find(id)
        Request.get(@session, "/categories/#{id}")
      end
    end
  end
end
