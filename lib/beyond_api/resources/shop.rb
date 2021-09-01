# frozen_string_literal: true

require "beyond_api/utils"

module BeyondApi
  autoload :ShopAddress,    "beyond_api/resources/shops/address"
  autoload :ShopAttributes, "beyond_api/resources/shops/attributes"
  autoload :ShopImages,     "beyond_api/resources/shops/images"
  autoload :ShopLegals,     "beyond_api/resources/shops/legals"
  autoload :ShopLocations,  "beyond_api/resources/shops/locations"

  class Shop < Base
    include BeyondApi::ShopAddress
    include BeyondApi::ShopAttributes
    include BeyondApi::ShopImages
    include BeyondApi::ShopLegals
    include BeyondApi::ShopLocations
    include BeyondApi::Utils

    #
    # A +GET+ request is used to retrieve the details of a shop.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/shop' -i -X GET \
    #       -H 'Accept: application/hal+json'
    #
    # @return [OpenStruct]
    #
    # @example
    #   session.shop.current
    #
    def current
      response, status = BeyondApi::Request.get(@session,
                                                "/shop")

      handle_response(response, status)
    end

    #
    # A +PATCH+ request is used to change attributes of a shop.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/shop' -i -X PATCH \
    #       -H 'Content-Type: application/json' \
    #       -H 'Accept: application/hal+json' \
    #       -H 'Authorization: Bearer <Access token>' \
    #       -d '{
    #     "name" : "anotherName",
    #     "primaryHostname" : "cornershop.amazingdiscounts.xyz",
    #     "fallbackHostname" : "cornershop.beyondshop.cloud",
    #     "tax" : {
    #       "taxModel" : "GROSS",
    #       "vatExempted" : false
    #     },
    #     "currencies" : [ "EUR", "USD", "GBP" ],
    #     "defaultCurrency" : "USD",
    #     "locales" : [ "en-GB", "de-DE" ],
    #     "defaultLocale" : "en-GB",
    #     "closedByMerchant" : false
    #   }'
    #
    # @beyond_api.scopes +shop:u+
    #
    # @param body [Hash] the request body
    #
    # @return [OpenStruct]
    #
    # @example
    #   body = {
    #     "name" => "anotherName",
    #     "primary_hostname" => "cornershop.amazingdiscounts.xyz",
    #     "fallback_hostname" => "cornershop.beyondshop.cloud",
    #     "tax" => {
    #       "taxModel" => "GROSS",
    #       "vatExempted" => false
    #     },
    #     "currencies" => [ "EUR", "USD", "GBP" ],
    #     "default_currency" => "USD",
    #     "locales" => [ "en-GB", "de-DE" ],
    #     "default_locale" => "en-GB",
    #     "closed_by_merchant" => false
    #   }
    #
    #   session.shop.update(body)
    #
    def update(body)
      response, status = BeyondApi::Request.patch(@session,
                                                  "/shop",
                                                  body)

      handle_response(response, status)
    end
  end
end
