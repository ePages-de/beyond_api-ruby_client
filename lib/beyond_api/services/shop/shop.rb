module BeyondApi
  module Shop
    class Shop < BaseService
      def show
        get("shop")
      end
    end
  end
end
