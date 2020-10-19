# frozen_string_literal: true

require "beyond_api/utils"

module BeyondApi
  class PaymentMethodDefinitions < Base
    include BeyondApi::Utils

    #
    # A +POST+ request is used to create a payment method definition on system level.
    #
    #   $ curl 'https://system.beyondshop.cloud/api/payment-method-definitions' -i -X POST \
    #       -H 'Content-Type: application/json' \
    #       -H 'Accept: application/hal+json' \
    #       -H 'Authorization: Bearer <Access token>' \
    #       -d '{
    #           "name": "credit-card",
    #           "referralUriTemplate": "https://example.com/merchants",
    #           "statusUriTemplate": "https://example.com/merchants/{shopId}/status",
    #           "disconnectUriTemplate": "https://example.com/merchants/{shopId}/disconnect",
    #           "createPaymentUriTemplate": "https://example.com/payments",
    #           "capturePaymentUriTemplate": "https://example.com/payments/{paymentId}/capture",
    #           "refundPaymentUriTemplate": "https://example.com/payments/{paymentId}/refund",
    #           "sandbox": "true",
    #             "workflow": "PAYMENT_ON_BUY",
    #             "captureWorkflow": "CAPTURE_ON_ORDER",
    #             "refund": "NO_REFUND",
    #             "logos": [{
    #               "setName" : "official",
    #               "variant" : "STOREFRONT",
    #               "uri" : "https://example.com/static/storefront.png"
    #             }],
    #           "officialName": {"de-DE" : "Ermögliche deinen Kunden, mit Kreditkarte zu bezahlen.",
    #           "en-US" : "Allow your customers to pay by credit card."
    #           },
    #             "officialDescription": {
    #               "de-DE" : "Ermögliche deinen Kunden, mit Kreditkarte zu bezahlen.",
    #               "en-US" : "Allow your customers to pay by credit card."
    #             },
    #             "defaultName": {
    #               "de-DE" : "Kreditkarte",
    #               "en-US" : "Credit card"
    #             },
    #             "defaultDescription": {"de-DE" : "Bezahlen Sie mit Kreditkarte.","en-US" : "Pay by credit card."}}'
    #
    # @beyond_api.scopes +paym:m+
    #
    # @param body [Hash] the request body
    #
    # @return [OpenStruct]
    #
    # @example
    #   @payment_method_definitions = session.payment_method_definitions.create(body)
    #
    def create(body)
      response, status = BeyondApi::Request.post(@session, "/payment-method-definitions", body)

      handle_response(response, status)
    end

    #
    # A +GET+ request is used to list all payment method definitions on system level.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/payment-method-definitions' -i -X GET \
    #       -H 'Accept: application/hal+json' \
    #       -H 'Authorization: Bearer <Access token>'
    #
    # @beyond_api.scopes +paym:m+
    #
    # @option params [Boolean] :paginated
    # @option params [Integer] :size the page size
    # @option params [Integer] :page the page number
    #
    # @return [OpenStruct]
    #
    # @example
    #   @payment_method_definitions = session.payment_method_definitions.all(size: 100, page: 0)
    #
    def all(params = {})
      handle_all_request("/payment-method-definitions", :payment_method_definitions, params)
    end

    #
    # A +GET+ request is used to deactivate a payment method.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/payment-method-definitions/credit-card' -i -X GET \
    #       -H 'Accept: application/hal+json' \
    #       -H 'Authorization: Bearer <Access token>'
    #
    # @beyond_api.scopes +pymt:u+
    #
    # @param payment_method_definition_id [String] the payment method definition UUID
    #
    # @return [OpenStruct]
    #
    # @example
    #   @payment_method_definition = session.payment_methods.find("credit-card")
    #
    def find(payment_method_definition_id)
      response, status = BeyondApi::Request.get(@session, "/payment-method-definitions/#{payment_method_definition_id}")

      handle_response(response, status)
    end

    #
    # A +PUT+ request is used to update a payment method definition on system level.
    #
    #   $ curl 'https://system.beyondshop.cloud/api/payment-method-definitions/credit-card' -i -X PUT \
    #       -H 'Content-Type: application/json' \
    #       -H 'Accept: application/hal+json' \
    #       -H 'Authorization: Bearer <Access token>' \
    #       -d '{
    #           "name": "credit-card-updated",
    #           "referralUriTemplate": "https://example.com/merchants",
    #           "statusUriTemplate": "https://example.com/merchants/{shopId}/status",
    #           "disconnectUriTemplate": "https://example.com/merchants/{shopId}/disconnect",
    #           "createPaymentUriTemplate": "https://example.com/payments",
    #           "capturePaymentUriTemplate": "https://example.com/payments/{paymentId}/capture",
    #           "refundPaymentUriTemplate": "https://example.com/payments/{paymentId}/refund",
    #           "workflow": "PAYMENT_ON_SELECTION",
    #           "captureWorkflow": "CAPTURE_ON_DEMAND",
    #           "refund": "NO_REFUND",
    #           "logos": [{
    #             "setName" : "official",
    #             "variant" : "STOREFRONT",
    #             "uri" : "https://example.com/static/storefront.png"
    #           }],
    #           "officialName": {"de-DE" : "Ermögliche deinen Kunden, mit Kreditkarte zu bezahlen.",
    #           "en-US" : "Allow your customers to pay by credit card."
    #           },
    #           "officialDescription": {
    #             "de-DE" : "Ermögliche deinen Kunden, mit Kreditkarte zu bezahlen.",
    #             "en-US" : "Allow your customers to pay by credit card."
    #           },
    #           "defaultName": {
    #             "de-DE" : "Kreditkarte",
    #             "en-US" : "Credit card"
    #           },
    #           "defaultDescription": {"de-DE" : "Bezahlen Sie mit Kreditkarte.","en-US" : "Pay by credit card."}}'
    #
    # @beyond_api.scopes +paym:m+
    #
    # @param payment_method_definition_id [String] the payment method definition UUID
    # @param body [Hash] the request body
    #
    # @return [OpenStruct]
    #
    # @example
    #   @payment_method_definition = session.payment_method_definitions.update("credit_card", body)
    #
    def update(payment_method_definition_id, body)
      response, status = BeyondApi::Request.put(@session, "/payment-method-definitions/#{payment_method_definition_id}")

      handle_response(response, status)
    end

    #
    # A +DELETE+ request is used to delete a payment method definition on system level.
    #
    #   $ curl 'https://system.beyondshop.cloud/api/payment-method-definitions/credit-card' -i -X DELETE \
    #       -H 'Accept: application/hal+json' \
    #       -H 'Authorization: Bearer <Access token>'
    #
    # @return true
    #
    # @example
    #   session.payment_method_definitions.delete("credit-card")
    #
    def delete(payment_method_definition_id)
      response, status = BeyondApi::Request.delete(@session, "/payment-method-definitions/#{payment_method_definition_id}", body)

      handle_response(response, status, respond_with_true: true)
    end
  end
end
