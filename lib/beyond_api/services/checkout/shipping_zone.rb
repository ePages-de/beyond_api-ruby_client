module BeyondApi
  module Checkout
    class ShippingZone < BaseService
      def all
        Request.new(@session).get("shipping-zones")
      end
    end
  end
end
