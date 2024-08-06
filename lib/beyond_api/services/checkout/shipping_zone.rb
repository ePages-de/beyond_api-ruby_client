module BeyondApi
  module Shop
    class ShippingZone < BaseService
      def all
        # TODO: iterate over all pages
        BeyondApi::Request.get(@session, "/shipping-zones")
      end
    end
  end
end
