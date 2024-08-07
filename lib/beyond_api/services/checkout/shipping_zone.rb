module BeyondApi
  module Checkout
    class ShippingZone < BaseService
      def all
        # TODO: iterate over all pages
        Request.new(@session).get("/shipping-zones")
      end
    end
  end
end
