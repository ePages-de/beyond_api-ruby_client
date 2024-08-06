module BeyondApi
  module ProductManagement
    class Category < BaseService
      def find(id)
        BeyondApi::Request.get(@session, "/categories/#{id}")
      end
    end
  end
end
