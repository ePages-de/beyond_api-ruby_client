module BeyondApi
  module Shop
    class Address < BaseService
      def get
        BeyondApi::Request.get(@session, "/shop/address")
      end
    end
  end
end
