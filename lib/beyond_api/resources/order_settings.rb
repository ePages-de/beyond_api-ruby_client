# frozen_string_literal: true

require "beyond_api/utils"

module BeyondAPI
  class PaymentMethods < Base
    include BeyondAPI::Utils

    #
    # A +POST+ request is used to activate a payment method..
    #
    # @scopes pymt:u
    #
    # @param payment_method_id [String] the payment method UUID
    #
    # @return true
    #
    # @example
    #   session.payment_methods.activate("268a8629-55cd-4890-9013-936b9b5ea14c")
    #
    def activate(payment_method_id)
      response, status = BeyondAPI::Request.post(@session, "/payment-methods/#{payment_method_id}/activate")

      handle_response(response, status, respond_with_true: true)
    end

    #
    # A +GET+ request is used to list all payment methods in a paged way.
    #
    # @scopes +pymt:r
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
      response, status = BeyondAPI::Request.get(@session, "/payment-methods", params)

      handle_response(response, status)
    end

    #
    # A +POST+ request is used to deactivate a payment method..
    #
    # @scopes pymt:u
    #
    # @param payment_method_id [String] the payment method UUID
    #
    # @return true
    #
    # @example
    #   session.payment_methods.deactivate("268a8629-55cd-4890-9013-936b9b5ea14c")
    #
    def deactivate(payment_method_id)
      response, status = BeyondAPI::Request.post(@session, "/payment-methods/#{payment_method_id}/deactivate")

      handle_response(response, status, respond_with_true: true)
    end

    #
    # A +GET+ request is used to activate a webhook subscription.
    #
    # @scopes +pymt:r
    #
    # @param payment_method_id [String] the paument method UUID
    #
    # @return [OpenStruct]
    #
    # @example
    #   session.payment_methods.find("268a8629-55cd-4890-9013-936b9b5ea14c")
    #
    def find(payment_method_id)
      response, status = BeyondAPI::Request.get(@session, "/payment-methods/#{payment_method_id}")

      handle_response(response, status)
    end

    #
    # A +PUT+ request is used to sort payment methods.
    #
    # @scopes +pymt:u
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
      response, status = BeyondAPI::Request.put(@session, "/payment-methods", body)

      handle_response(response, status, respond_with_true: true)
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
