module BeyondApi
  module ProductManagement
    class VariationImage < BaseService
      def all(product_id, variation_id)
        BeyondApi::Request.get(@session, "/products/#{product_id}/variations/#{variation_id}/images")
      end
    end
  end
end
