# frozen_string_literal: true

module BeyondApi
  module Shop
    class Address < BaseService
      def show
        get('shop/address')
      end
    end
  end
end
