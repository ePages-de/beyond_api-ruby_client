# frozen_string_literal: true

require "beyond_api/utils"

module BeyondAPI
  class CheckoutSettings < Base
    include BeyondAPI::Utils

    #
    # A +GET+ request is used to retrieve the checkout settings.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/checkout-settings' -i -X GET \
    #       -H 'Accept: application/hal+json' \
    #       -H 'Authorization: Bearer <Access token>'
    #
    # @beyond_api.scopes +cset:r+
    #
    # @return [OpenStruct]
    #
    # @example
    #   @checkout_settiongs = session.checkout_settings.all
    #
    def all
      response, status = BeyondAPI::Request.get(@session, "/checkout-settings")

      handle_response(response, status)
    end

    # A +PUT+ request is used to update the checkout settings.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/checkout-settings' -i -X PUT \
    #       -H 'Content-Type: application/json' \
    #       -H 'Accept: application/hal+json' \
    #       -H 'Authorization: Bearer <Access token>' \
    #       -d ' {
    #       "minimumOrderValue" : {
    #         "currency" : "EUR",
    #         "amount" : 50
    #       },
    #       "mustAcceptTermsAndConditions" : true
    #   }'
    def update(body)
      response, status = BeyondAPI::Request.put(@session, "/checkout-settings", body)

      handle_response(response, status)
    end
  end
end
