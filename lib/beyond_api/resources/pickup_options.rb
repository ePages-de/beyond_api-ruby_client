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

    #
    # A +DELETE+ request is used to delete a pickup option.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/pickup-options/d253a31b-3892-4196-ae16-c5d8d6b05791' -i -X DELETE
    #
    # @beyond_api.scopes +shpz:d+
    #
    # @param pickup_option_id [String] the pickup option UUID
    #
    # @return true
    #
    # @example
    #   session.pickup_options.delete("d253a31b-3892-4196-ae16-c5d8d6b05791")
    #
    def delete(pickup_option_id)
      response, status = BeyondApi::Request.delete(@session, "/pickup-options/#{pickup_option_id}")

      handle_response(response, status, respond_with_true: true)
    end

    #
    # A +GET+ request is used to retrieve the details of a pickup option.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/pickup-options/76302c10-761f-43c1-9d18-52ad16bd52e8' -i -X GET \
    #       -H 'Content-Type: application/json' \
    #       -H 'Accept: application/hal+json' \
    #       -H 'Authorization: Bearer <Access token>'
    #
    # @beyond_api.scopes +shpz:r+
    #
    # @param pickup_option_id [String] the pickup option UUID
    #
    # @return [OpenStruct]
    #
    # @example
    #   @pickup_option = session.pickup_options.find("76302c10-761f-43c1-9d18-52ad16bd52e8")
    #
    def find(pickup_option_id)
      response, status = BeyondApi::Request.get(@session, "/pickup-options/#{pickup_option_id}")

      handle_response(response, status)
    end

    #
    # A +PUT+ request is used to sort the pickup options. This is done by passing the self-links of the pickup options in the desired order. The request must contain URIs for all pickup options of the given page.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/pickup-options' -i -X PUT \
    #       -H 'Content-Type: text/uri-list' \
    #       -H 'Authorization: Bearer <Access token>' \
    #       -d 'https://api-shop.beyondshop.cloud/api/pickup-options/bff3673f-91c1-4e09-a8ab-562a3a553fac
    #           https://api-shop.beyondshop.cloud/api/pickup-options/7b4d36fc-ac0f-44a3-8655-f2bd05c2a42d
    #           https://api-shop.beyondshop.cloud/api/pickup-options/630b63ee-c7d8-4953-9b7c-c874fd795154'
    #
    # @beyond_api.scopes +shpz:u+
    #
    # @param pickup_option_ids [Array] the pickup option UUIDs
    #
    # @return [OpenStruct]
    #
    # @example
    #   pickup_option_ids = [
    #     "bff3673f-91c1-4e09-a8ab-562a3a553fac",
    #     "7b4d36fc-ac0f-44a3-8655-f2bd05c2a42d",
    #     "630b63ee-c7d8-4953-9b7c-c874fd795154"
    #   ]
    #
    #   session.pickup_options.sort(pickup_option_ids)
    #
    def sort(pickup_option_ids)
      body = pickup_option_ids.map { |id| "#{@session.api_url}/pickup-options/#{id}" }
      response, status = BeyondApi::Request.put(@session, "/pickup-options", body)

      handle_response(response, status, respond_with_true: true)
    end

    #
    # A +PUT+ request is used to update a pickup option.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/pickup-options/5765b837-db5b-49a9-a659-68d00376e42a' -i -X PUT \
    #       -H 'Content-Type: application/json' \
    #       -H 'Accept: application/hal+json' \
    #       -H 'Authorization: Bearer <Access token>' \
    #       -d '{
    #       "name" : "New name",
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
    #       "locationId" : "c9179393-abcc-450a-8cf4-875b39647ab6"
    #   }'
    #
    # @beyond_api.scopes +shpz:u+
    #
    # @param pickup_option_id [String] the pickup option UUID
    # @param body [Hash] the request body
    #
    # @return [OpenStruct]
    #
    # @example
    #   body = {
    #     name: "New name",
    #     description: "We will send you an email when your items are ready for pickup. Please bring a copy of your order confirmation.",
    #     tax_class: "REGULAR",
    #     free_pickup_value: {
    #       currency: "EUR",
    #       amount: 50
    #     ,
    #     fixed_price: {
    #       tax_model: "GROSS",
    #       currency: "EUR",
    #       amount: 1
    #     ,
    #     phone_number_required: true,
    #     location_id: "c9179393-abcc-450a-8cf4-875b39647ab6"
    #   }
    #
    #   @pickup_option = session.pickup_options.update("5765b837-db5b-49a9-a659-68d00376e42a", body)
    #
    def update(pickup_option_id, body)
      response, status = BeyondApi::Request.put(@session, "/pickup-options/#{pickup_option_id}", body)

      handle_response(response, status)
    end
  end
end
