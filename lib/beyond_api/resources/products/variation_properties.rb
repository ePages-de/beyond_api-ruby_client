# frozen_string_literal: true

require "beyond_api/utils"

module BeyondAPI
  module ProductVariationProperties

    #
    # A +PATCH+ request is used to update the variation properties of a variation product.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/products/51953b86-7ccc-4e80-acbd-1a2fc921fc2e/variation-properties' -i -X PATCH \
    #       -H 'Content-Type: application/hal+json' \
    #       -H 'Accept: application/hal+json' \
    #       -H 'Authorization: Bearer <Access token>' \
    #       -d '[ {
    #     "property" : "salesPrice",
    #     "enabled" : true
    #     }, {
    #       "property" : "listPrice",
    #       "enabled" : true
    #     }, {
    #       "property" : "refPrice",
    #       "enabled" : true
    #     }, {
    #       "property" : "manufacturerPrice",
    #       "enabled" : true
    #     }, {
    #       "property" : "productIdentifiers",
    #       "enabled" : true
    #   } ]'
    #
    # @beyond_api.scopes +prod:r+
    #
    # @param product_id [String] the product UUID
    # @param body [Array<Hash>] the request body
    #
    # @return [OpenStruct]
    #
    # @example
    #   body = [{
    #   	"property": "salesPrice",
    #   	"enabled": true
    #   }, {
    #   	"property": "listPrice",
    #   	"enabled": true
    #   }, {
    #   	"property": "refPrice",
    #   	"enabled": true
    #   }, {
    #   	"property": "manufacturerPrice",
    #   	"enabled": true
    #   }, {
    #   	"property": "productIdentifiers",
    #   	"enabled": true
    #   }]
    #
    #   @variation_properties = session.products.update_variation_properties("7f32696a-df56-4380-a91b-fffb97f025b4", body)
    #
    def update_variation_properties(product_id, body)
      response, status = BeyondAPI::Request.patch(@session, "/products/#{product_id}/variation-properties", body)

      handle_response(response, status)
    end

    #
    # A +GET+ request is used to retrieve the variation properties of a variation product.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/products/ea81446c-8fec-418c-8b3c-6e43fdee713a/variation-properties' -i -X GET \
    #       -H 'Accept: application/hal+json' \
    #       -H 'Authorization: Bearer <Access token>'
    #
    # @beyond_api.scopes +prod:r+
    #
    # @param product_id [String] the product UUID
    #
    # @return [OpenStruct]
    #
    # @example
    #   @variation_properties = session.products.variation_properties("7f32696a-df56-4380-a91b-fffb97f025b4")
    #
    def variation_properties(product_id)
      response, status = BeyondAPI::Request.get(@session, "/products/#{product_id}/variation-properties")

      handle_response(response, status)
    end
  end
end
