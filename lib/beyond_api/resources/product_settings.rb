# frozen_string_literal: true

require "beyond_api/utils"

module BeyondAPI
  class ProductSettings < Base
    include BeyondAPI::Utils

    #
    # A +GET+ request is used to retrieve the product settings.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/product-settings' -i -X GET \
    #       -H 'Authorization: Bearer <Access token>'
    #
    # @beyond_api.scopes +prst:r+
    #
    # @return [OpenStruct]
    #
    # @example
    #   @product_settings = session.product_settings.all
    #
    def all
      response, status = BeyondAPI::Request.get(@session, "/product_settings")

      handle_response(response, status)
    end
  end
end
