# frozen_string_literal: true

require "beyond_api/utils"

module BeyondApi
  autoload :ProductAttachments,         "beyond_api/resources/products/attachments"
  autoload :ProductAvailability,        "beyond_api/resources/products/availability"
  autoload :ProductCrossSells,          "beyond_api/resources/products/cross_sells"
  autoload :ProductCustomAttributes,    "beyond_api/resources/products/custom_attributes"
  autoload :ProductImages,              "beyond_api/resources/products/images"
  autoload :ProductSearches,            "beyond_api/resources/products/searches"
  autoload :ProductVariationProperties, "beyond_api/resources/products/variation_properties"
  autoload :ProductVideos,              "beyond_api/resources/products/videos"

  class Products < Base
    include BeyondApi::ProductAttachments
    include BeyondApi::ProductAvailability
    include BeyondApi::ProductCrossSells
    include BeyondApi::ProductCustomAttributes
    include BeyondApi::ProductImages
    include BeyondApi::ProductSearches
    include BeyondApi::ProductVariationProperties
    include BeyondApi::ProductVideos
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
    # @option params [Boolean] :paginated
    # @option params [Integer] :size the page size
    # @option params [Integer] :page the page number
    #
    # @return [OpenStruct]
    #
    # @example
    #   @products = session.products.all(size: 100, page: 0)
    #
    def all(params = {})
      path = "/products"

      handle_all_request(path, :products, params)
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
    #       "min" : 2,
    #       "max" : 4,
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
    #      "min": 2,
    #      "max": 4,
    #      "displayUnit": "WEEKS"
    #    }
    #   }
    #
    #   @product = session.products.create(body)
    #
    def create(body)
      path = "/products"

      response, status = BeyondApi::Request.post(@session,
                                                 path,
                                                 body)

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
    #   session.products.delete("c06c61af-f99a-4698-90fa-8c3199ca732f")
    #
    def delete(product_id)
      path = "/products/#{product_id}"

      response, status = BeyondApi::Request.delete(@session,
                                                   path)

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
    #   @product = session.products.find("75ebcb57-aefb-4963-8225-060c528e070d")
    #
    def find(product_id)
      path = "/products/#{product_id}"

      response, status = BeyondApi::Request.get(@session,
                                                path)

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
    #       "name" : "patched name",
    #       "description" : "patched description. <p><br></p><blockquote> <ol><li><strong>\n<h1></h1><h6></h6><em><a href=\"http://example.com\" target=\"_blank\"><u>this is my test html</u></a>\n</em></strong> </li></ol> </blockquote>",
    #       "productIdentifiers" : null,
    #       "manufacturer" : "patched manufacturer"
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
    #   @product = session.products.update("b69e3f47-03b8-40d2-843c-ae89a3d9bcdd", body)
    #
    def update(product_id, body)
      path = "/products/#{product_id}"

      response, status = BeyondApi::Request.patch(@session,
                                                  path,
                                                  body)

      handle_response(response, status)
    end

    #
    # A +POST+ request is used to assign a variation attribute as the variation images differentiator for a variation product.
    #
    # @beyond_api.scopes +prod:u+
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/products/f205294b-17dc-4f75-8b5e-5df72abb96df/variation-attributes/491fedf4-37a9-4bcf-98b8-cff2f82879b7/make-differentiator' -i -X POST \
    #       -H 'Content-Type: application/hal+json' \
    #       -H 'Accept: application/hal+json' \
    #       -H 'Authorization: Bearer <Access token>'
    #
    # @param product_id [String] the product UUID
    # @param variation_attribute_id [String] the variation attribute UUID
    #
    # @return [true]
    #
    # @example
    #   session.products.assign_variation_images_differentiator("f205294b-17dc-4f75-8b5e-5df72abb96df", "491fedf4-37a9-4bcf-98b8-cff2f82879b7")
    #
    def assign_variation_attribute_as_differentiator(product_id, variation_attribute_id)
      path = "/products/#{product_id}/variation-attributes/#{variation_attribute_id}/make-differentiator"

      response, status = BeyondApi::Request.post(@session,
                                                 path)

      handle_response(response, status, respond_with_true: true)
    end

    alias create_variation create
    alias find_variation find
    alias update_variation update
  end
end
