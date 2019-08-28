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
    # @return [OpenStruct]
    #
    # @example
    #   @order_settings = session.payment_methods.all
    #
    def all(params)
      response, status = BeyondAPI::Request.get(@session, "/order-settings")

      handle_response(response, status)
    end

    #
    # A +PUT+ request is used to update the order settings.
    #
    # @scopes +oset:u
    #
    # @param body [Hash] the request body
    #
    # @return [OpenStruct]
    #
    # @example
    #   body = {
    #     "invoiceCancelationNote"=> "This is an invoice cancelation note",
    #     "invoiceCancellationNote"=> "This is an invoice cancellation note",
    #     "defaultDeliveryDateNote"=> "This is the default delivery date note",
    #     "defaultInvoiceNote"=> "This is the default invoice note",
    #     "orderNumberConfiguration"=> {
    #       "stringPrefix"=> "2017-shop-",
    #       "nextNumericSuffix"=> 1000,
    #       "numericSuffixLength"=> 4
    #     },
    #     "invoiceNumberConfiguration"=> {
    #       "stringPrefix"=> "2017-invoice-",
    #       "nextNumericSuffix"=> 1000,
    #       "numericSuffixLength"=> 4
    #     }
    #   }
    #
    #   @order_settings = session.order_settings.update(body)
    #
    def update(order_settings, body)
      response, status = BeyondAPI::Request.put(@session, "/order-settings", body)

      handle_response(response, status)
    end
  end
end
