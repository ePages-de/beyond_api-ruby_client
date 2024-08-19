# frozen_string_literal: true

module BeyondApi
  module Checkout
    class ShippingZone < BaseService
      def all
        get('shipping-zones')
      end
    end
  end
end
