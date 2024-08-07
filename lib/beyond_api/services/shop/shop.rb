module BeyondApi
  module Shop
    class Shop < BaseService
      def details
        Request.new(@session).get("shop")
      end
    end
  end
end
