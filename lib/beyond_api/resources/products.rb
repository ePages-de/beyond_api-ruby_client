# frozen_string_literal: true

require "beyond_api/utils"
require "beyond_api/resources/products/custom_attributes"

module BeyondApi
  class Products < Base
    include BeyondApi::ProductCustomAttribute
    include BeyondApi::Utils

    #
    # A +GET+ request will list all of the products in a paged manner. The returned data is an excerpt projection, which includes a small subset of product properties.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/products' -i -X GET \
    #       -H 'Content-Type: application/hal+json' \
    #       -H 'Accept: application/hal+json' \
    #       -H 'Authorization: Bearer <Access token>'
    #
    # @beyond_api.scopes +prod:r+
    #
    # @option params [Integer] :size the page size
    # @option params [Integer] :page the page number
    #
    # @return [OpenStruct]
    #
    # @example
    #   @products = session.products.all(size: 100, page: 0)
    #
    def all(params = {})
      response, status = BeyondApi::Request.get(@session, "/products", params)

      handle_response(response, status)
    end

    #
    # A +POST+ request is used to create a product.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/products' -i -X POST \
    #       -H 'Content-Type: application/json' \
    #       -H 'Authorization: Bearer <Access token>' \
    #       -d '{
    #     "sku" : "123456789-001",
    #     "name" : "Rioja Castillo de Puerto (2013)",
    #     "description" : "Spain\nRioja Tempranillo",
    #     "manufacturer" : "Grape Vineyard",
    #     "essentialFeatures" : "Dry. 12% alcohol. Best vine variety.",
    #     "tags" : [ "Bestseller", "Red Wine", "Sale" ],
    #     "productIdentifiers" : [ {
    #       "type" : "EAN",
    #       "value" : "9780134308135"
    #     } ],
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
    #     "onSale" : true,
    #     "visible" : true,
    #     "taxClass" : "REGULAR",
    #     "shippingWeight" : 100,
    #     "maxOrderQuantity" : 6,
    #     "shippingDimension" : {
    #       "length" : 1500,
    #       "width" : 1000,
    #       "height" : 2000
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
    #     "shippingPeriod" : {
    #       "minDays" : 2,
    #       "maxDays" : 4,
    #       "displayUnit" : "WEEKS"
    #     }
    #   }'
    #
    # @beyond_api.scopes +prod:c+
    #
    # @param body [Hash] the request body
    #
    # @return [OpenStruct]
    #
    # @example
    #   body = {
    #    "sku": "123456789-001",
    #    "name": "Rioja Castillo de Puerto (2013)",
    #    "description": "Spain\nRioja Tempranillo",
    #    "manufacturer": "Grape Vineyard",
    #    "essentialFeatures": "Dry. 12% alcohol. Best vine variety.",
    #    "tags": ["Bestseller", "Red Wine", "Sale"],
    #    "productIdentifiers": [{
    #      "type": "EAN",
    #      "value": "9780134308135"
    #    }],
    #    "salesPrice": {
    #      "taxModel": "NET",
    #      "amount": 8.7,
    #      "currency": "EUR"
    #    },
    #    "listPrice": {
    #      "taxModel": "NET",
    #      "amount": 10.95,
    #      "currency": "EUR"
    #    },
    #    "manufacturerPrice": {
    #      "taxModel": "NET",
    #      "amount": 99.95,
    #      "currency": "EUR"
    #    },
    #    "onSale": true,
    #    "visible": true,
    #    "taxClass": "REGULAR",
    #    "shippingWeight": 100,
    #    "maxOrderQuantity": 6,
    #    "shippingDimension": {
    #      "length": 1500,
    #      "width": 1000,
    #      "height": 2000
    #    },
    #    "refPrice": {
    #      "refQuantity": 1,
    #      "unit": "LITER",
    #      "quantity": 0.75,
    #      "price": {
    #        "taxModel": "NET",
    #        "amount": 11.6,
    #        "currency": "EUR"
    #      }
    #    },
    #    "shippingPeriod": {
    #      "minDays": 2,
    #      "maxDays": 4,
    #      "displayUnit": "WEEKS"
    #    }
    #   }
    #
    #   @product = session.products.create(body)
    #
    def create(body)
      response, status = BeyondApi::Request.post(@session, "/products", body)

      handle_response(response, status)
    end

    #
    # A +DELETE+ request is used to delete a product or variation product. When a variation product is deleted, all its variations are deleted as well.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/products/c06c61af-f99a-4698-90fa-8c3199ca732f' -i -X DELETE \
    #       -H 'Accept: application/hal+json' \
    #       -H 'Authorization: Bearer <Access token>'
    #
    # @beyond_api.scopes +prod:d+
    #
    # @param product_id [String] the product UUID
    #
    # @return true
    #
    # @example
    #   session.products.delete("f461fb56-1984-4ade-bd4e-007c273cc923")
    #
    def delete(product_id)
      response, status = BeyondApi::Request.delete(@session, "/products/#{product_id}")

      handle_response(response, status, respond_with_true: true)
    end

    #
    # A +GET+ request is used to retrieve the details of a product.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/products/75ebcb57-aefb-4963-8225-060c528e070d' -i -X GET \
    #       -H 'Content-Type: application/json' \
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
    #   @product = session.products.find("f461fb56-1984-4ade-bd4e-007c273cc923")
    #
    def find(product_id)
      response, status = BeyondApi::Request.get(@session, "/products/#{product_id}")

      handle_response(response, status)
    end

    #
    # A +PATCH+ request is used to update a product partially with json content type.
    #
    # @beyond_api.scopes +prod:u+
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/products/b69e3f47-03b8-40d2-843c-ae89a3d9bcdd' -i -X PATCH \
    #       -H 'Content-Type: application/json' \
    #       -H 'Accept: application/hal+json' \
    #       -H 'Authorization: Bearer <Access token>' \
    #       -d '{
    #     "name" : "patched name",
    #     "description" : "patched description. <p><br></p><blockquote> <ol><li><strong>\n<h1></h1><h6></h6><em><a href=\"http://example.com\" target=\"_blank\"><u>this is my test html</u></a>\n</em></strong> </li></ol> </blockquote>",
    #     "productIdentifiers" : null,
    #     "manufacturer" : "patched manufacturer"
    #   }'
    #
    # @param product_id [String] the product UUID
    # @param body [Hash] the request body
    #
    # @return [OpenStruct]
    #
    # @example
    #   body = {
    #     "name": "patched name",
    #     "description": "patched description. <p><br></p><blockquote> <ol><li><strong>\n<h1></h1><h6></h6><em><a href=\"http://example.com\" target=\"_blank\"><u>this is my test html</u></a>\n</em></strong> </li></ol> </blockquote>",
    #     "productIdentifiers": null,
    #     "manufacturer": "patched manufacturer"
    #   }
    #   @product = session.products.update("75ebcb57-aefb-4963-8225-060c528e070d", body)
    #
    def update(product_id, body)
      response, status = BeyondApi::Request.patch(@session, "/products/#{product_id}", body)

      handle_response(response, status)
    end

    alias_method :create_variation, :create
    alias_method :find_variation,   :find
    alias_method :update_variation, :update
  end
end
