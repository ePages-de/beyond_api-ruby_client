# frozen_string_literal: true

require "beyond_api/utils"

module BeyondAPI
  module ProductVariationAvailability

    #
    # A +POST+ request is used to adjust the available stock of a variation.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/products/9171c3ed-0b53-43ef-8fed-c081f55560f4/variations/a6d8275f-66cd-4cd7-8623-2d005f1ab7fc/availability/adjust-available-stock' -i -X POST \
    #       -H 'Content-Type: application/json' \
    #       -H 'Accept: application/hal+json' \
    #       -H 'Authorization: Bearer <Access token>' \
    #       -d '{ "relativeAmount" : -1 }'
    #
    # @beyond_api.scopes +prda:u+
    #
    # @param product_id [String] the product UUID
    # @param variation_id [String] the product variation UUID
    # @param body [Hash] the request body
    #
    # @return [OpenStruct]
    #
    # @example
    #   @availability = session.products.adjust_stock_level(product_id, variation_id, { relativeAmount => -1 })
    #
    def variation_adjust_stock_level(product_id, variation_id, body)
      response, status = BeyondAPI::Request.post(@session, "/products/#{product_id}/variations/#{variation_id}/availability/enable-stock-management", body)

      handle_response(response, status)
    end

    #
    # A +GET+ request is used to retrieve the availability of a variation.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/products/7fdc9424-1ddd-4fba-a59d-3d5de08d89d1/variations/13b28149-975a-4f47-ad54-bdc4ca4a07ec/availability' -i -X GET \
    #       -H 'Content-Type: application/json' \
    #       -H 'Accept: application/hal+json' \
    #       -H 'Authorization: Bearer <Access token>'
    #
    # @beyond_api.scopes +prda:r+
    #
    # @param product_id [String] the product UUID
    # @param variation_id [String] the product variation UUID
    #
    # @return [OpenStruct]
    #
    # @example
    #   @availability = session.products.variation_availability("fb22d408-00dc-47e3-ae58-e35769bdb428", "13b28149-975a-4f47-ad54-bdc4ca4a07ec")
    #
    def variation_availability(product_id, variation_id)
      response, status = BeyondAPI::Request.get(@session, "/products/#{product_id}/variations/#{variation_id}/availability")

      handle_response(response, status)
    end

    #
    # A +POST+ request is used to enable purchasability for a variation.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/products/131400c9-54f1-4510-a0c4-2c7e34c57336/variations/cec06f66-5a80-4638-a74c-c916e1173c21/availability/enable-purchasability' -i -X POST \
    #       -H 'Content-Type: application/json' \
    #       -H 'Accept: application/hal+json' \
    #       -H 'Authorization: Bearer <Access token>'
    #
    # @beyond_api.scopes +prda:u+
    #
    # @param product_id [String] the product UUID
    # @param variation_id [String] the product variation UUID
    #
    # @return [OpenStruct]
    #
    # @example
    #   @availability = session.products.variation_enable_purchasability("17e3a92b-6f3b-4415-bd8f-c9c8921a5a73", "13b28149-975a-4f47-ad54-bdc4ca4a07ec")
    #
    def variation_enable_purchasability(product_id, variation_id)
      response, status = BeyondAPI::Request.post(@session, "/products/#{product_id}/variations/#{variation_id}/availability/enable-purchasability")

      handle_response(response, status)
    end

    #
    # A +POST+ request is used to disable purchasability for a variation.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/products/f3b9d880-b73e-45a4-b04c-e03acae4fcdd/variations/40337e9c-a187-4bb6-9a0d-c8d66386cb8d/availability/disable-purchasability' -i -X POST \
    #       -H 'Content-Type: application/json' \
    #       -H 'Accept: application/hal+json' \
    #       -H 'Authorization: Bearer <Access token>'
    #
    # @beyond_api.scopes +prda:u+
    #
    # @param product_id [String] the product UUID
    #
    # @return true
    #
    # @example
    #   @availability = session.products.variation_disable_purchasability("17e3a92b-6f3b-4415-bd8f-c9c8921a5a73", "13b28149-975a-4f47-ad54-bdc4ca4a07ec")
    #
    def variation_disable_purchasability(product_id, variation_id)
      response, status = BeyondAPI::Request.post(@session, "/products/#{product_id}/variations/#{variation_id}/availability/disable-purchasability")

      handle_response(response, status)
    end
  end
end
