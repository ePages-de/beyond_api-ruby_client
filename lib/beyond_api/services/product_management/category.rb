module BeyondApi
  module ProductManagement
    class Category < BaseService
      def find(id)
        get("categories/#{id}")
      end

      def all(params = {})
        fetch_all_pages("categories", params)
      end

      def create(body)
        post("categories", body)
      end

      def update(id, body)
        put("categories/#{id}", body)
      end

      def delete(id)
        super("categories/#{id}") # Concerns::Connection delete method
      end
    end
  end
end
