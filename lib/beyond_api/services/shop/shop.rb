module BeyondApi
  module Shop
    class Shop < BaseService
      def details
        BeyondApi::Request.get(@session, "/shop")
      end
    end
  end
end
