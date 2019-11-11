# frozen_string_literal: true

require "beyond_api/utils"

module BeyondApi
  class ProductAttributeDefinitions < Base
    include BeyondApi::Utils

    #
    # A +GET+ request will list the available product attribute definitions.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/product-attribute-definitions' -i -X GET \
    #       -H 'Authorization: Bearer <Access token>'
    #
    # @beyond_api.scopes +prad:r+
    #
    # @option param [Integer] :size the page size
    # @option param [Integer] :page the page number
    #
    # @return [OpenStruct]
    #
    # @example
    #   @product_attribute_definitions = session.product_attribute_definitions.all(size: 100, page: 0)
    #
    def all(params = {})
      response, status = BeyondApi::Request.get(@session, "/product-attribute-definitions", params)

      handle_response(response, status)
    end

    #
    # A +POST+ request is used to create a product attribute definition.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/product-attribute-definitions' -i -X POST \
    #       -H 'Content-Type: application/json' \
    #       -H 'Authorization: Bearer <Access token>' \
    #       -d '{
    #     "key" : "filling_capacity",
    #     "type" : "NUMBER",
    #     "displayName" : "Filling Capacity",
    #     "format" : "#,###.## ml"
    #   }'
    #
    # @beyond_api.scopes +prad:c+
    #
    # @param product_attribute_name [String] the product attribute key
    #
    # @return [OpenStruct]
    #
    # @example
    #   body = {
    #   	"key": "filling_capacity",
    #   	"type": "NUMBER",
    #   	"displayName": "Filling Capacity",
    #   	"format": "#,###.## ml"
    #   }
    #   @product_attribute_definition = session.product_attribute_definitions.create(body)
    #
    def create(body)
      response, status = BeyondApi::Request.post(@session, "/product-attribute-definitions", body)

      handle_response(response, status)
    end

    #
    # A +DELETE+ request is used to delete a product attachment.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/products/00add006-beaa-46fe-bb73-f8ebae15082d/attachments/9a44e585-571a-4253-9248-54a4c418c7e2' -i -X DELETE \
    #       -H 'Content-Type: application/hal+json' \
    #       -H 'Accept: application/hal+json' \
    #       -H 'Authorization: Bearer <Access token>'
    #
    # @beyond_api.scopes +prad:d+
    #
    # @param product_attribute_name [String] the product attribute key
    #
    # @return [true]
    #
    # @example
    #   session.product_attribute_definitions.delete("filling_capacity")
    #
    def delete(product_attribute_name)
      response, status = BeyondApi::Request.delete(@session, "/product-attribute-definitions/#{product_attribute_name}")

      handle_response(response, status, respond_with_true: true)
    end

    #
    # A +GET+ request is used to retrieve a single product attribute definition by name.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/product-attribute-definitions/filling_capacity' -i -X GET \
    #       -H 'Authorization: Bearer <Access token>'
    #
    # @beyond_api.scopes +prad:r+
    #
    # @param product_attribute_name [String] the product attribute key
    #
    # @return [OpenStruct]
    #
    # @example
    #   @product_attribute_definition = session.product_attribute_definitions.find("filling_capacity")
    #
    def find(product_attribute_name)
      response, status = BeyondApi::Request.get(@session, "/product-attribute-definitions/#{product_attribute_name}")

      handle_response(response, status)
    end
  end
end
