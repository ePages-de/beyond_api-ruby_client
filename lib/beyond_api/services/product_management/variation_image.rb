module BeyondApi
  module ProductManagement
    class VariationImage < BaseService
      def all(product_id, variation_id)
        Request.new(@session).get("/products/#{product_id}/variations/#{variation_id}/images")
      end
    end
  end
end
