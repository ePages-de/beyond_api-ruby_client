# frozen_string_literal: true

require "beyond_api/utils"

module BeyondAPI
  class OrderSettings < Base
    include BeyondAPI::Utils

    #
    # A +GET+ request is used to retrieve the order settings.
    #
    # @scopes +oset:r
    #
    # @option params [Integer] :size the page size
    # @option params [Integer] :page the page number
    #
    # @return [OpenStruct]
    #
    # @example
    #   session.payment_methods.all(size: 100, page: 0)
    #
    def all(params)
      response, status = BeyondAPI::Request.get(@session, "/order-settings", params)

      handle_response(response, status)
    end

    #
    # A +PUT+ request is used to update a payment method.
    #
    # @scopes +pymt:u
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
      response, status = BeyondAPI::Request.put(@session, "/payment-methods/#{payment_method_id}", body)

      handle_response(response, status)
    end
  end
end
