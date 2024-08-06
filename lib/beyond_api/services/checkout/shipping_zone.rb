module BeyondApi
  module Checkout
    class ShippingZone < BaseService
      def all
        # TODO: iterate over all pages
        Request.get(@session, "/shipping-zones")
      end
    end
  end
end
