module BeyondApi
  module Shop
    class Address < BaseService
      def get
        Request.new(@session).get("shop/address")
      end
    end
  end
end
