# frozen_string_literal: true

require "beyond_api/utils"

module BeyondApi
  module ShopAddress

    #
    # A +GET+ request is used to retrieve the details of a shop’s address.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/shop/address' -i -X GET
    #
    # @return [OpenStruct]
    #
    # @example
    #   session.shop.address
    #
    def address
      response, status = BeyondApi::Request.get(@session, "/shop/address")

      handle_response(response, status)
    end

    #
    # A +PATCH+ request is used to patch a shop’s address partially with json content type.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/shop/address' -i -X PATCH \
    #       -H 'Content-Type: application/json' \
    #       -H 'Accept: application/hal+json' \
    #       -H 'Authorization: Bearer <Access token>' \
    #       -d '{
    #     "city" : "Barcelona"
    #   }'
    #
    # @beyond_api.scopes +shad:u+
    #
    # @param body [Hash] the request body
    #
    # @return [OpenStruct]
    #
    # @example
    #   body = {
    #     "city" => "Barcelona"
    #   }
    #
    #   session.shop.update_address(body)
    #
    def update_address(body)
      response, status = BeyondApi::Request.patch(@session, "/shop/address", body)

      handle_response(response, status)
    end
  end
end
