# frozen_string_literal: true

module BeyondApi
  class OrderSettings < Base
    include BeyondApi::Utils

    #
    # A +GET+ request is used to retrieve the order settings.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/order-settings' -i -X GET \
    #       -H 'Accept: application/hal+json' \
    #       -H 'Authorization: Bearer <Access token>'
    #
    # @beyond_api.scopes +oset:r+
    #
    # @return [OpenStruct]
    #
    # @example
    #   @order_settings = session.payment_methods.all
    #
    def all
      response, status = BeyondApi::Request.get(@session, "/order-settings")

      handle_response(response, status)
    end

    #
    # A +PUT+ request is used to update the order settings.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/order-settings' -i -X PUT \
    #     -H 'Content-Type: application/json' \
    #     -H 'Accept: application/hal+json' \
    #     -H 'Authorization: Bearer <Access token>' \
    #     -d '{
    #         "invoiceCancelationNote" : "This is an invoice cancelation note",
    #         "defaultDeliveryDateNote" : "This is the default delivery date note",
    #         "defaultInvoiceNote" : "This is the default invoice note",
    #         "orderNumberConfiguration" : {
    #           "stringPrefix" : "2017-shop-",
    #           "nextNumericSuffix" : 1000,
    #           "numericSuffixLength" : 4
    #         },
    #         "invoiceNumberConfiguration" : {
    #           "stringPrefix" : "2017-invoice-",
    #           "nextNumericSuffix" : 1000,
    #           "numericSuffixLength" : 4
    #         },
    #         "customOrderOpenMailText" : " Your <br /> 1",
    #         "customOrderCanceledMailText" : " Your <br /> 2",
    #         "customInvoiceCustomerMailText" : " Your <br /> 3",
    #         "customInvoiceCanceledMailText" : " Your <br /> 4",
    #         "customOrderShippedMailText" : " Your <br /> 5",
    #         "customOrderPendingMailText" : " Your <br /> 6",
    #         "customOrderReturnedMailText" : " Your <br /> 7"
    #    }'
    #
    # @beyond_api.scopes +oset:u+
    #
    # @param body [Hash] the request body
    #
    # @return [OpenStruct]
    #
    # @example
    #   body = {
    #     "invoiceCancelationNote" : "This is an invoice cancelation note",
    #     "defaultDeliveryDateNote" : "This is the default delivery date note",
    #     "defaultInvoiceNote" : "This is the default invoice note",
    #     "orderNumberConfiguration" : {
    #       "stringPrefix" : "2017-shop-",
    #       "nextNumericSuffix" : 1000,
    #       "numericSuffixLength" : 4
    #     },
    #     "invoiceNumberConfiguration" : {
    #       "stringPrefix" : "2017-invoice-",
    #       "nextNumericSuffix" : 1000,
    #       "numericSuffixLength" : 4
    #     },
    #     "customOrderOpenMailText" : " Your <br /> 1",
    #     "customOrderCanceledMailText" : " Your <br /> 2",
    #     "customInvoiceCustomerMailText" : " Your <br /> 3",
    #     "customInvoiceCanceledMailText" : " Your <br /> 4",
    #     "customOrderShippedMailText" : " Your <br /> 5",
    #     "customOrderPendingMailText" : " Your <br /> 6",
    #     "customOrderReturnedMailText" : " Your <br /> 7"
    #   }
    #
    #   @order_settings = session.order_settings.update(body)
    #
    def update(body)
      response, status = BeyondApi::Request.put(@session, "/order-settings", body)

      handle_response(response, status)
    end
  end
end
