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
    # @option param [Boolean] :paginated
    # @option param [Integer] :size the page size
    # @option param [Integer] :page the page number
    #
    # @return [OpenStruct]
    #
    # @example
    #   @product_attribute_definitions = session.product_attribute_definitions.all(size: 100, page: 0)
    #
    def all(params = {})
      if params[:paginated] == false
        result = all_paginated(page: 0, size: 1000)

        (1..result[:page][:total_pages] - 1).each do |page|
          result[:embedded][:product_attribute_definition].concat(all_paginated(page: page, size: 1000)[:embedded][:product_attribute_definitions])
        end

        result.is_a?(Hash) ? result.delete(:page) : result.delete_field(:page)
        result
      else
        all_paginated(params)
      end
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
    # A +DELETE+ request is used to delete a product attribute definition.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/product-attribute-definitions/color' -i -X DELETE \
    #       -H 'Authorization: Bearer <Access token>'
    #
    # @beyond_api.scopes +prad:d+
    #
    # @param product_attribute_name [String] the product attribute key
    #
    # @return [true]
    #
    # @example
    #   session.product_attribute_definitions.delete("color")
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

    private

      def all_paginated(params = {})
        response, status = BeyondApi::Request.get(@session, "/product-attribute-definitions", params)
        handle_response(response, status)
      end
  end
end
