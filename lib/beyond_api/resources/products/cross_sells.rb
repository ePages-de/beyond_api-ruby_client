# frozen_string_literal: true

module BeyondApi
  module Products::CrossSells
    #
    # A +POST+ request is used to create a cross-sell for a product.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/products/43df85ec-e123-4a56-bcc3-c3c52eb23ca9/cross-sells' -i -X POST \
    #       -H 'Content-Type: application/json' \
    #       -H 'Authorization: Bearer <Access token>' \
    #       -d '{
    #       "name" : "Red wines from Spain cross-sell",
    #       "type" : "MANUAL",
    #       "queries" : [ {
    #         "ids" : [ "22e8b6a6-7d8e-4b08-be63-dde9bced2604", "b18e9e3c-685c-4e37-837c-9047b88fc91e" ],
    #         "strategy" : "all-ids-match"
    #       } ]
    #   }'
    #
    # @beyond_api.scopes +prcs:c+
    #
    # @param product_id [String] the product UUID
    # @param body [Hash] the request body
    #
    # @return [OpenStruct]
    #
    # @example
    #   body = {
    #     name => "Red wines from Spain cross-sell",
    #     type => "MANUAL",
    #     queries => [ {
    #       "ids" : [ "22e8b6a6-7d8e-4b08-be63-dde9bced2604", "b18e9e3c-685c-4e37-837c-9047b88fc91e" ],
    #       "strategy" : "all-ids-match"
    #     } ]
    #   }
    #
    #   @cross_sell = session.products.create_cross_sell("43df85ec-e123-4a56-bcc3-c3c52eb23ca9", body)
    #
    def create_cross_sell(product_id, body)
      response, status = BeyondApi::Request.post(@session, "/products/#{product_id}/cross-sells", body)

      handle_response(response, status)
    end

    #
    # A +GET+ request is used to retrieve the cross-sell of a product.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/products/20174c3f-1a3f-4401-91f6-c7498e897c82/cross-sells/6176b350-06ff-4c52-b3cf-ba032ea79468' -i -X GET \
    #       -H 'Content-Type: application/json' \
    #       -H 'Authorization: Bearer <Access token>'
    #
    # @beyond_api.scopes +prcs:r+
    #
    # @param product_id [String] the product UUID
    # @param cross_sell_id [String] the cross-sell UUID
    #
    # @return [OpenStruct]
    #
    # @example
    #
    #   @cross_sell = session.products.cross_sell("20174c3f-1a3f-4401-91f6-c7498e897c82", "6176b350-06ff-4c52-b3cf-ba032ea79468")
    #
    def cross_sell(product_id, cross_sell_id)
      response, status = BeyondApi::Request.get(@session, "/products/#{product_id}/cross-sells/#{cross_sell_id}")

      handle_response(response, status)
    end

    #
    # A +GET+ request is used to retrieve the cross-sells of a product.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/products/a21188a2-7109-4cd1-8253-2f366d86ff5d/cross-sells' -i -X GET \
    #       -H 'Content-Type: application/json' \
    #       -H 'Authorization: Bearer <Access token>'
    #
    # @beyond_api.scopes +prcs:r+
    #
    # @param product_id [String] the product UUID
    #
    # @return [OpenStruct]
    #
    # @example
    #
    #   @cross_sells = session.products.cross_sells("a21188a2-7109-4cd1-8253-2f366d86ff5d")
    #
    def cross_sells(product_id)
      response, status = BeyondApi::Request.get(@session, "/products/#{product_id}/cross-sells")

      handle_response(response, status)
    end

    #
    # A +DELETE+ request is used to delete a product attribute.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/products/b80cdb11-0e97-41e3-8559-4d426bd28ba1/cross-sells/67ecb3ef-8472-4509-9e5a-c76945e8d963' -i -X DELETE \
    #       -H 'Authorization: Bearer <Access token>'
    #
    # @beyond_api.scopes +prcs:d+
    #
    # @param product_id [String] the product UUID
    # @param cross_sell_id [String] the cross-sell UUID
    #
    # @return [OpenStruct]
    #
    # @example
    #
    #   session.products.cross_sell("b80cdb11-0e97-41e3-8559-4d426bd28ba1", "67ecb3ef-8472-4509-9e5a-c76945e8d963")
    #
    def delete_cross_sell(product_id, cross_sell_id)
      response, status = BeyondApi::Request.delete(@session, "/products/#{product_id}/cross-sells/#{cross_sell_id}")

      handle_response(response, status, respond_with_true: true)
    end

    #
    # A +PUT+ request is used to update a cross-sell for a product.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/products/4ed7a15a-9ef8-415f-8161-87498b1ecd4f/cross-sells/b18d96f4-dfdf-47f3-b2dc-ce1653829674' -i -X PUT \
    #       -H 'Content-Type: application/json' \
    #       -H 'Authorization: Bearer <Access token>' \
    #       -d '{
    #       "name" : "sale rose wine cross-selling",
    #       "type" : "SMART",
    #       "queries" : [ {
    #         "tags" : [ "Rosé Wine", "Sale" ],
    #         "strategy" : "any-tags-match"
    #       } ]
    #   }'
    #
    # @beyond_api.scopes +prcs:u+
    #
    # @param product_id [String] the product UUID
    # @param cross_sell_id [String] the cross-sell UUID
    # @param body [Hash] the request body
    #
    # @return [OpenStruct]
    #
    # @example
    #   body = {
    #     name => "sale rose wine cross-selling",
    #     type => "SMART",
    #     queries => [ {
    #         tags => [ "Rosé Wine", "Sale" ],
    #         strategy => "any-tags-match"
    #     } ]
    #   }
    #
    #   @cross_sell = session.products.update_cross_sell("4ed7a15a-9ef8-415f-8161-87498b1ecd4f", "b18d96f4-dfdf-47f3-b2dc-ce1653829674", body)
    #
    def update_cross_sell(product_id, attribute_name, body)
      response, status = BeyondApi::Request.put(@session, "/products/#{product_id}/cross-sells/#{cross_sell_id}", body)

      handle_response(response, status)
    end
  end
end
