# frozen_string_literal: true

require "beyond_api/utils"

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
    # @beyond_api.scopes pymt:u
    #
    # @param payment_method_id [String] the payment method UUID
    #
    # @return true
    #
    # @example
    #   session.payment_methods.activate("268a8629-55cd-4890-9013-936b9b5ea14c")
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
    # @beyond_api.scopes +pymt:r
    #
    # @option params [Integer] :size the page size
    # @option params [Integer] :page the page number
    #
    # @return [OpenStruct]
    #
    # @example
    #   session.payment_methods.all(size: 100, page: 0)
    #
    def all(params = {})
      response, status = BeyondApi::Request.get(@session, "/payment-methods", params)

      handle_response(response, status)
    end

    #
    # A +POST+ request is used to deactivate a payment method.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/payment-methods/157f930f-328a-4d7a-974d-66bc3b4dd28e/deactivate' -i -X POST \
    #       -H 'Accept: application/hal+json' \
    #       -H 'Authorization: Bearer <Access token>'
    #
    # @beyond_api.scopes pymt:u
    #
    # @param payment_method_id [String] the payment method UUID
    #
    # @return true
    #
    # @example
    #   session.payment_methods.deactivate("268a8629-55cd-4890-9013-936b9b5ea14c")
    #
    def deactivate(payment_method_id)
      response, status = BeyondApi::Request.post(@session, "/payment-methods/#{payment_method_id}/deactivate")

      handle_response(response, status, respond_with_true: true)
    end

    #
    # A +GET+ request is used to activate a webhook subscription.
    #
    # @beyond_api.scopes +pymt:r
    #
    # @param payment_method_id [String] the paument method UUID
    #
    # @return [OpenStruct]
    #
    # @example
    #   session.payment_methods.find("268a8629-55cd-4890-9013-936b9b5ea14c")
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
    #       -d 'https://api-shop.beyondshop.cloud/api/payment-methods/80fa2f12-53e4-42c4-8991-c5a3ddb7596e
    #           https://api-shop.beyondshop.cloud/api/payment-methods/8b54c275-b766-44be-9ed5-c1e269594e0f
    #           https://api-shop.beyondshop.cloud/api/payment-methods/779d08fb-a26d-447e-aef8-ed3642f05e5b
    #           https://api-shop.beyondshop.cloud/api/payment-methods/c02de15b-1e6d-4990-9318-83749
    #
    # @beyond_api.scopes +pymt:u
    #
    # @param payment_method_ids [Array] the payment method UUIDs
    #
    # @return [OpenStruct]
    #
    # @example
    #   payment_method_ids = [
    #     '6f3bc033-c2d1-4f44-80e3-1b668f6bd699',
    #     '6f3bc033-c2d1-4f44-80e3-1b618f6sd692',
    #     '6f3bc033-c2d1-4f44-80e3-1b628f6br698'
    #   ]
    #
    #   session.payment_methods.sort(paymen)
    #
    def sort(payment_method_ids)
      body = []
      payment_method_ids.each do |payment_method|
        body << "#{@session.api_url}/payment-methods/#{payment_method}"
      end
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
    # @beyond_api.scopes +pymt:u
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
    #   @payment_method = session.payment_methods.update("6f3bc033-c2d1-4f44-80e3-1b668f6bd699", body)
    #
    def update(payment_method_id, body)
      response, status = BeyondApi::Request.put(@session, "/payment-methods/#{payment_method_id}", body)

      handle_response(response, status)
    end
  end
end
