# frozen_string_literal: true

require "beyond_api/utils"

module BeyondAPI
  module ProductVariations

    #
    # A +PATCH+ request is used to update a variation partially with json content type.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/products/7cf4b5b1-b141-4869-96d1-4eaee8bf7563/variations/9f93fdd0-2d21-4ea9-b9d7-e9a53edb091b' -i -X PATCH \
    #       -H 'Content-Type: application/json' \
    #       -H 'Accept: application/hal+json' \
    #       -H 'Authorization: Bearer <Access token>' \
    #       -d '{
    #     "salesPrice" : {
    #       "taxModel" : "NET",
    #       "amount" : 8.7,
    #       "currency" : "EUR"
    #     },
    #     "listPrice" : {
    #       "taxModel" : "NET",
    #       "amount" : 10.95,
    #       "currency" : "EUR"
    #     },
    #     "manufacturerPrice" : {
    #       "taxModel" : "NET",
    #       "amount" : 99.95,
    #       "currency" : "EUR"
    #     },
    #     "refPrice" : {
    #       "refQuantity" : 1,
    #       "unit" : "LITER",
    #       "quantity" : 0.75,
    #       "price" : {
    #         "taxModel" : "NET",
    #         "amount" : 11.6,
    #         "currency" : "EUR"
    #       }
    #     },
    #     "sku" : "my-new-sku",
    #     "productIdentifiers" : [ {
    #       "type" : "EAN",
    #       "value" : "9780134308135"
    #     } ]
    #   }'
    #
    # @beyond_api.scopes +prod:r+
    #
    # @param product_id [String] the product UUID
    # @param variation_id [String] the variation UUID
    # @param body [Hash] the request body
    #
    # @return [OpenStruct]
    #
    # @example
    #   body = {
    #     "salesPrice"=> {
    #       "taxModel"=> "NET",
    #       "amount"=> 8.7,
    #       "currency"=> "EUR"
    #     },
    #     "listPrice"=> {
    #       "taxModel"=> "NET",
    #       "amount"=> 10.95,
    #       "currency"=> "EUR"
    #     },
    #     "manufacturerPrice"=> {
    #       "taxModel"=> "NET",
    #       "amount"=> 99.95,
    #       "currency"=> "EUR"
    #     },
    #     "refPrice"=> {
    #       "refQuantity"=> 1,
    #       "unit"=> "LITER",
    #       "quantity"=> 0.75,
    #       "price"=> {
    #         "taxModel"=> "NET",
    #         "amount"=> 11.6,
    #         "currency"=> "EUR"
    #       }
    #     },
    #     "sku"=> "my-new-sku",
    #     "productIdentifiers"=> [{
    #       "type"=> "EAN",
    #       "value"=> "9780134308135"
    #     }]
    #   }
    #   @product = session.products.update_variation("7f32696a-df56-4380-a91b-fffb97f025b4", "f6e5bb16-af2e-440f-acd3-a883ad3c1922", body)
    #
    def update_variation(product_id, variation_id, body)
      response, status = BeyondAPI::Request.patch(@session, "/products/#{product_id}/variations/#{variation_id}")

      handle_response(response, status)
    end

    #
    # A +GET+ request is used to retrieve the variation of a product.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/products/5f6e426e-c8d9-48ba-9b37-9a8eb6381373/variations/f6e5bb16-af2e-440f-acd3-a883ad3c1922' -i -X GET \
    #       -H 'Content-Type: application/json' \
    #       -H 'Accept: application/hal+json' \
    #       -H 'Authorization: Bearer <Access token>'
    #
    # @beyond_api.scopes +prod:r+
    #
    # @param product_id [String] the product UUID
    # @param variation_id [String] the variation UUID
    #
    # @return [OpenStruct]
    #
    # @example
    #   @product = session.products.variation("7f32696a-df56-4380-a91b-fffb97f025b4", "f6e5bb16-af2e-440f-acd3-a883ad3c1922")
    #
    def variation(product_id, variation_id)
      response, status = BeyondAPI::Request.get(@session, "/products/#{product_id}/variations/#{variation_id}")

      handle_response(response, status)
    end

    #
    # A +GET+ request is used to retrieve the variations of a product.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/products/dc1b5caf-51ea-4fcd-b1ba-0c5128e91d17/variations' -i -X GET \
    #       -H 'Content-Type: application/json' \
    #       -H 'Authorization: Bearer <Access token>'
    #
    # @beyond_api.scopes +prod:r+
    #
    # @param product_id [String] the product UUID
    # @option params [Integer] :size the page size
    # @option params [Integer] :page the page number
    #
    # @return [OpenStruct]
    #
    # @example
    #   @products = session.products.variation("7f32696a-df56-4380-a91b-fffb97f025b4", { size: 20, page: 0 })
    #
    def variations(product_id, params = {})
      response, status = BeyondAPI::Request.get(@session, "/products/#{product_id}/images", params)

      handle_response(response, status)
    end
  end
end
