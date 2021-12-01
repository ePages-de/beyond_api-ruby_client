# frozen_string_literal: true

require "beyond_api/utils"

module BeyondApi
  module ProductCustomAttributes
    #
    # A +POST+ request is used to create a product attribute, which defines the value of a certain {product attribute definition}[http://docs.beyondshop.cloud/#resources-product-attribute-definitions] for a specific {product}[http://docs.beyondshop.cloud/#resources-products].
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/products/0c0e1699-d2a4-44d0-bed9-64b2fa1a7713/attributes' -i -X POST \
    #       -H 'Content-Type: application/json' \
    #       -H 'Authorization: Bearer <Access token>' \
    #       -d '{
    #       "key" : "colour",
    #       "value" : "Yellow"
    #   }'
    #
    # @beyond_api.scopes +prat:c+
    #
    # @param product_id [String] the product UUID
    # @param body [Hash] the request body
    #
    # @return [OpenStruct]
    #
    # @example
    #   body = {
    #     "key" => "colour",
    #     "value" => "Yellow"
    #   }
    #
    #   @custom_attribute = session.products.create_custom_attribute("0c0e1699-d2a4-44d0-bed9-64b2fa1a7713", body)
    #
    def create_custom_attribute(product_id, body)
      response, status = BeyondApi::Request.post(@session, "/products/#{product_id}/attributes", body)

      handle_response(response, status)
    end

    #
    # A +GET+ request is used to retrieve detailed information about a specific product attribute.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/products/d389347c-568e-4785-8216-91e4f8850c66/attributes/key' -i -X GET \
    #       -H 'Content-Type: application/json' \
    #       -H 'Authorization: Bearer <Access token>'
    #
    # @beyond_api.scopes +prat:r+
    #
    # @param product_id [String] the product UUID
    # @param attribute_name [String] the key of custom attribute
    #
    # @return [OpenStruct]
    #
    # @example
    #
    #   @custom_attribute = session.products.custom_attribute("d389347c-568e-4785-8216-91e4f8850c66", "key")
    #
    def custom_attribute(product_id, attribute_name)
      response, status = BeyondApi::Request.get(@session, "/products/#{product_id}/attributes/#{attribute_name}")

      handle_response(response, status)
    end

    #
    # A +GET+ request is used to retrieve all product attributes for a product.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/products/57f0ef04-9dac-462f-9dd4-606f7551cc7b/attributes' -i -X GET \
    #       -H 'Content-Type: application/json' \
    #       -H 'Authorization: Bearer <Access token>'
    #
    # @beyond_api.scopes +prat:r+
    #
    # @param product_id [String] the product UUID
    #
    # @return [OpenStruct]
    #
    # @example
    #
    #   @custom_attributes = session.products.custom_attributes("57f0ef04-9dac-462f-9dd4-606f7551cc7b")
    #
    def custom_attributes(product_id)
      response, status = BeyondApi::Request.get(@session, "/products/#{product_id}/attributes")

      handle_response(response, status)
    end

    #
    # A +DELETE+ request is used to delete a product attribute.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/products/fec3b6f3-83d0-467a-abc5-d51019e57b51/attributes/farbe' -i -X DELETE \
    #       -H 'Authorization: Bearer <Access token>'
    #
    # @beyond_api.scopes +prat:d+
    #
    # @param product_id [String] the product UUID
    # @param attribute_name [String] the key of custom attribute
    #
    # @return [OpenStruct]
    #
    # @example
    #
    #   session.products.delete_custom_attribute("fec3b6f3-83d0-467a-abc5-d51019e57b51", "farbe")
    #
    def delete_custom_attribute(product_id, attribute_name)
      response, status = BeyondApi::Request.delete(@session, "/products/#{product_id}/attributes/#{attribute_name}")

      handle_response(response, status, respond_with_true: true)
    end

    #
    # A +PUT+ request is used to update the value of a product attribute. If the specified product attribute doesn’t exist, it will be created with the response as described in {Create product attribute}[http://docs.beyondshop.cloud/#resources-product-attribute-create].
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/products/82ed44e9-664d-47c0-8b07-09adecfdbf20/attributes/key' -i -X PUT \
    #       -H 'Content-Type: application/json' \
    #       -H 'Authorization: Bearer <Access token>' \
    #       -d '{
    #     "value" : "green"
    #   }'
    #
    # @beyond_api.scopes +prat:u+
    #
    # @param product_id [String] the product UUID
    # @param attribute_name [String] the key of custom attribute
    # @param body [Hash] the request body
    #
    # @return [OpenStruct]
    #
    # @example
    #   body = {
    #     "value" : "green"
    #    }
    #
    #   @custom_attribute = session.products.update_custom_attribute("82ed44e9-664d-47c0-8b07-09adecfdbf20", "key", body)
    #
    def update_custom_attribute(product_id, attribute_name, body)
      response, status = BeyondApi::Request.put(@session, "/products/#{product_id}/attributes/#{attribute_name}", body)

      handle_response(response, status)
    end
  end
end
