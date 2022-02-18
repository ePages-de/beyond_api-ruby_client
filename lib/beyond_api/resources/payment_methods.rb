# frozen_string_literal: true

module BeyondApi
  class PaymentMethods < Base
    include BeyondApi::Utils

    #
    # A +POST+ request is used to activate a payment method.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/payment-methods/da313b73-ea6b-49c7-8a3d-d707934098b8/activate' -i -X POST \
    #       -H 'Accept: application/hal+json' \
    #       -H 'Authorization: Bearer <Access token>'
    #
    # @beyond_api.scopes +pymt:u+
    #
    # @param payment_method_id [String] the payment method UUID
    #
    # @return true
    #
    # @example
    #   session.payment_methods.activate("da313b73-ea6b-49c7-8a3d-d707934098b8")
    #
    def activate(payment_method_id)
      response, status = BeyondApi::Request.post(@session, "/payment-methods/#{payment_method_id}/activate")

      handle_response(response, status, respond_with_true: true)
    end

    #
    # A +GET+ request is used to list all payment methods in a paged way.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/payment-methods' -i -X GET \
    #       -H 'Content-Type: application/hal+json' \
    #       -H 'Accept: application/hal+json' \
    #       -H 'Authorization: Bearer <Access token>'
    #
    # @beyond_api.scopes +pymt:r+
    #
    # @option params [Boolean] :paginated
    # @option params [Integer] :size the page size
    # @option params [Integer] :page the page number
    #
    # @return [OpenStruct]
    #
    # @example
    #   @payment_methods = session.payment_methods.all(size: 100, page: 0)
    #
    def all(params = {})
      handle_all_request("/payment-methods", :payment_methods, params)
    end

    #
    # A +POST+ request is used to deactivate a payment method.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/payment-methods/157f930f-328a-4d7a-974d-66bc3b4dd28e/deactivate' -i -X POST \
    #       -H 'Accept: application/hal+json' \
    #       -H 'Authorization: Bearer <Access token>'
    #
    # @beyond_api.scopes +pymt:u+
    #
    # @param payment_method_id [String] the payment method UUID
    #
    # @return true
    #
    # @example
    #   session.payment_methods.deactivate("157f930f-328a-4d7a-974d-66bc3b4dd28e")
    #
    def deactivate(payment_method_id)
      response, status = BeyondApi::Request.post(@session, "/payment-methods/#{payment_method_id}/deactivate")

      handle_response(response, status, respond_with_true: true)
    end

    #
    # A +GET+ request is used to retrieve the details of a payment method.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/payment-methods/7d964402-8f67-48f3-af86-6c35abe4fa08' -i -X GET \
    #       -H 'Content-Type: application/json' \
    #       -H 'Accept: application/hal+json' \
    #       -H 'Authorization: Bearer <Access token>'
    #
    # @beyond_api.scopes +pymt:r+
    #
    # @param payment_method_id [String] the payment method UUID
    #
    # @return [OpenStruct]
    #
    # @example
    #   @payment_method = session.payment_methods.find("7d964402-8f67-48f3-af86-6c35abe4fa08")
    #
    def find(payment_method_id)
      response, status = BeyondApi::Request.get(@session, "/payment-methods/#{payment_method_id}")

      handle_response(response, status)
    end

    #
    # A +PUT+ request is used to sort payment methods.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/payment-methods' -i -X PUT \
    #       -H 'Content-Type: text/uri-list' \
    #       -H 'Authorization: Bearer <Access token>' \
    #       -d 'https://api-shop.beyondshop.cloud/api/payment-methods/dd59a52b-0661-49f9-82c3-e063ff80328f
    #           https://api-shop.beyondshop.cloud/api/payment-methods/66b22fb2-2184-4ea1-9143-44ae1d230d49
    #           https://api-shop.beyondshop.cloud/api/payment-methods/a9462eae-ed72-4e29-b853-f04537c8ab11
    #           https://api-shop.beyondshop.cloud/api/payment-methods/84172da4-5baa-4a99-b779-33d673bed6d1'
    #
    # @beyond_api.scopes +pymt:u+
    #
    # @param payment_method_ids [Array] the payment method UUIDs
    #
    # @return [OpenStruct]
    #
    # @example
    #   payment_method_ids = [
    #     "dd59a52b-0661-49f9-82c3-e063ff80328f",
    #     "66b22fb2-2184-4ea1-9143-44ae1d230d49",
    #     "a9462eae-ed72-4e29-b853-f04537c8ab11",
    #     "84172da4-5baa-4a99-b779-33d673bed6d1"
    #   ]
    #
    #   session.payment_methods.sort(payment_method_ids)
    #
    def sort(payment_method_ids)
      body = payment_method_ids.map { |id| "#{@session.api_url}/payment-methods/#{id}" }
      response, status = BeyondApi::Request.put(@session, "/payment-methods", body)

      handle_response(response, status, respond_with_true: true)
    end

    #
    # A +PUT+ request is used to update a payment method.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/payment-methods/dc00a5af-d21e-49f0-99f2-ef67ca6fa782' -i -X PUT \
    #       -H 'Content-Type: application/json' \
    #       -H 'Accept: application/hal+json' \
    #       -H 'Authorization: Bearer <Access token>' \
    #       -d '{
    #           "name" : "Another name",
    #           "description" : "Pay by Converge.",
    #           "taxClass" : "REGULAR",
    #           "discountOrFee" : {
    #             "type" : "ABSOLUTE",
    #             "absoluteValue" : {
    #               "taxModel" : "GROSS",
    #               "currency" : "EUR",
    #               "amount" : 2.0
    #             }
    #           },
    #           "serviceableCountries" : [ "DE" ],
    #           "minimumOrderValue" : {
    #             "currency" : "EUR",
    #             "amount" : 10.0
    #           }
    #       }'
    #
    # @beyond_api.scopes +pymt:u+
    #
    # @param payment_method_id [String] the payment method UUID
    # @param body [Hash] the request body
    #
    # @return [OpenStruct]
    #
    # @example
    #   body = {
    #     "name" => "Another name",
    #     "description" => "Pay by Converge.",
    #     "tax_class" => "REGULAR",
    #     "discount_or_fee" => {
    #       "type" => "ABSOLUTE",
    #       "absolute_value" => {
    #         "tax_model" => "GROSS",
    #         "currency" => "EUR",
    #         "amount" => 2.0
    #       }
    #     },
    #     "serviceable_countries" => [ "DE" ],
    #     "minimum_order_value" => {
    #       "currency" => "EUR",
    #       "amount" => 10.0
    #     }
    #   }
    #
    #   @payment_method = session.payment_methods.update("dc00a5af-d21e-49f0-99f2-ef67ca6fa782", body)
    #
    def update(payment_method_id, body)
      response, status = BeyondApi::Request.put(@session, "/payment-methods/#{payment_method_id}", body)

      handle_response(response, status)
    end
  end
end
