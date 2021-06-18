# frozen_string_literal: true

require "beyond_api/utils"

module BeyondApi
  class PickupOptions < Base
    include BeyondApi::Utils

    #
    # A +GET+ request is used to list all pickup options of the shop in a paged way.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/pickup-options' -i -X GET \
    #       -H 'Accept: application/hal+json' \
    #       -H 'Authorization: Bearer <Access token>'
    #
    # @option params [Boolean] :paginated
    # @option params [Integer] :size the page size
    # @option params [Integer] :page the page number
    #
    # @return [OpenStruct]
    #
    # @example
    #   @pickup_options = session.pickup_options.all(size: 100, page: 0)
    #
    def all(params = {})
      handle_all_request("/pickup-options", :pickup_options, params)
    end

    #
    # A +POST+ request is used to create a pickup option.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/pickup-options' -i -X POST \
    #       -H 'Content-Type: application/json' \
    #       -H 'Authorization: Bearer <Access token>' \
    #       -d '{
    #       "name" : "My little Cornershop - St.Ives",
    #       "description" : "We will send you an email when your items are ready for pickup. Please bring a copy of your order confirmation.",
    #       "taxClass" : "REGULAR",
    #       "freePickupValue" : {
    #         "currency" : "EUR",
    #         "amount" : 50
    #       },
    #       "fixedPrice" : {
    #         "taxModel" : "GROSS",
    #         "currency" : "EUR",
    #         "amount" : 1
    #       },
    #       "phoneNumberRequired" : true,
    #       "locationId" : "cb554eb6-2768-4491-afd2-6bcd0aec0937"
    #   }'
    #
    # @beyond_api.scopes +shpz:c+
    #
    # @param body [Hash] the request body
    #
    # @return [OpenStruct]
    #
    # @example
    #   body = {
    #     name: "My little Cornershop - St.Ives",
    #     description: "We will send you an email when your items are ready for pickup. Please bring a copy of your order confirmation.",
    #     tax_class: "REGULAR",
    #     free_pickup_value: {
    #       currency: "EUR",
    #       amount: 50
    #     },
    #     fixed_price: {
    #       tax_model: "GROSS",
    #       currency: "EUR",
    #       amount: 1
    #      },
    #      phone_number_required: true,
    #      location_id: "cb554eb6-2768-4491-afd2-6bcd0aec0937"
    #   }
    #
    #   @pickup_option = session.pickup_options.create(body)
    #
    def create(body)
      response, status = BeyondApi::Request.post(@session, "/pickup-options", body)

      handle_response(response, status)
    end
  end
end
