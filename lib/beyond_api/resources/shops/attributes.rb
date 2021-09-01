# frozen_string_literal: true

require "beyond_api/utils"

module BeyondApi
  module ShopAttributes
    #
    # A +GET+ request is used to retrieve a particular shop attribute by its name.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/shop/attributes/second-unknown-attribute-name' -i -X GET \
    #       -H 'Authorization: Bearer <Access token>'
    #
    # @beyond_api.scopes +shat:r+
    #
    # @param attribute_name [String] the attribute name
    #
    # @return [OpenStruct]
    #
    # @example
    #   @shop_attribute = session.shop.attribute("second-unknown-attribute-name")
    #
    def attribute(attribute_name)
      response, status = BeyondApi::Request.get(@session, "/shop/attributes/#{attribute_name}")

      handle_response(response, status)
    end

    #
    # A +GET+ request is used to retrieve a list of all shop attributes.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/shop/attributes' -i -X GET \
    #       -H 'Authorization: Bearer <Access token>'
    #
    # @beyond_api.scopes +shat:r+
    #
    # @option params [Integer] :size the page size
    # @option params [Integer] :page the page number
    #
    # @return [OpenStruct]
    #
    # @example
    #   @shop_attributes = session.shop.attributes(size: 5, page: 1)
    #
    def attributes(params = {})
      response, status = BeyondApi::Request.get(@session, "/shop/attributes", params)

      handle_response(response, status)
    end

    #
    # A +POST+ request is used to create a shop attribute.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/shop/attributes' -i -X POST \
    #       -H 'Content-Type: application/json' \
    #       -H 'Authorization: Bearer <Access token>' \
    #       -d '{
    #     "name" : "second-unknown-attribute-name",
    #     "value" : "correct-value",
    #     "public" : false
    #   }'
    #
    # @beyond_api.scopes +shat:c+
    #
    # @param body [Hash] the request body
    #
    # @return [OpenStruct]
    #
    # @example
    #   body = {
    #     "name" => "second-unknown-attribute-name",
    #     "value" => "correct-value",
    #     "public" => false
    #   }
    #
    #   session.shop.create_attribute(body)
    #
    def create_attribute(body)
      response, status = BeyondApi::Request.post(@session, "/shop/attributes", body)

      handle_response(response, status)
    end

    #
    # A +DELETE+ request is used to delete an shop attribute.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/shop/attributes/second-unknown-attribute-name' -i -X DELETE \
    #       -H 'Authorization: Bearer <Access token>'
    #
    # @beyond_api.scopes +shat:d+
    #
    # @param attribute_name [String] the attribute name
    #
    # @return true
    #
    # @example
    #   session.shop.delete_attribute("second-unknown-attribute-name")
    #
    def delete_attribute(attribute_name)
      response, status = BeyondApi::Request.delete(@session, "/shop/attributes/#{attribute_name}")

      handle_response(response, status, respond_with_true: true)
    end

    #
    # A +PUT+ request is used to update a shop attribute. This operation is idempotent and will create a new shop attribute if required.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/shop/attributes/second-unknown-attribute-name' -i -X PUT \
    #       -H 'Content-Type: application/json' \
    #       -H 'Authorization: Bearer <Access token>' \
    #       -d '{
    #     "value" : "new-value",
    #     "public" : false
    #   }'
    #
    # @beyond_api.scopes +shat:u+
    #
    # @param attribute_name [String] the attribute name
    # @param body [Hash] the request body
    #
    # @return [OpenStruct]
    #
    # @example
    #   body = {
    #     "value" => "new-value",
    #     "public" => false
    #   }
    #
    #   session.shop.update_attribute("second-unknown-attribute-name", body)
    #
    def update_attribute(attribute_name, body)
      response, status = BeyondApi::Request.put(@session, "/shop/attributes/#{attribute_name}", body)

      handle_response(response, status)
    end
  end
end
