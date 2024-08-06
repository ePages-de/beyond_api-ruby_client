module BeyondApi
  module Shop
    class Shop < BaseService
      def details
        Request.get(@session, "/shop")
      end
    end
  end
end
