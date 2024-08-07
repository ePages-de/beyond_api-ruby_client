module BeyondApi
  module Checkout
    class ShippingZone < BaseService
      def all
        get("shipping-zones")
      end
    end
  end
end
