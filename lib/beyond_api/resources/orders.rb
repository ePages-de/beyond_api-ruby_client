# frozen_string_literal: true

require "beyond_api/utils"

module BeyondApi
  class Orders < Base
    include BeyondApi::Utils

    #
    # A +GET+ request is used to retrieve the active payment processes. There is only one active payment process. See {Show payment process details}[http://docs.beyondshop.cloud/#resources-payment-process-get] for more information about the request and response structure.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/orders/208e2c1d-6610-43c7-b2f1-20aad6f029b9/processes/payments/active' -i -X GET \
    #       -H 'Content-Type: application/json' \
    #       -H 'Accept: application/hal+json' \
    #       -H 'Authorization: Bearer <Access token>'
    #
    # @beyond_api.scopes +pypr:r+
    #
    # @param order_id [String] the order UUID
    #
    # @return [OpenStruct]
    #
    # @example
    #   @payment_process = session.orders.active_payment_process("208e2c1d-6610-43c7-b2f1-20aad6f029b9")
    #
    def active_payment_process(order_id)
      path = "/orders/#{order_id}/processes/payments/active"

      response, status = BeyondApi::Request.get(@session,
                                                path)

      handle_response(response, status)
    end

    #
    # A +GET+ request is used to retrieve the active refund processes. There is only one active refund process. See {Show refund process details}[http://docs.beyondshop.cloud/#resources-refund-process-get] for more information about the request and response structure.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/orders/8613295f-4d44-4143-bfd0-6b81fc178618/processes/refunds/active' -i -X GET \
    #       -H 'Content-Type: application/json' \
    #       -H 'Accept: application/hal+json' \
    #       -H 'Authorization: Bearer <Access token>'
    #
    # @beyond_api.scopes +rfpr:r+
    #
    # @param order_id [String] the order UUID
    #
    # @return [OpenStruct]
    #
    # @example
    #   @refund_process = session.orders.active_refund_process("8613295f-4d44-4143-bfd0-6b81fc178618")
    #
    def active_refund_process(order_id)
      path = "/orders/#{order_id}/processes/refunds/active"

      response, status = BeyondApi::Request.get(@session,
                                                path)

      handle_response(response, status)
    end

    #
    # A +GET+ request is used to list all orders of the shop in a paged way. Each item in the response represents a summary of the order data.
    #
    # @beyond_api.scopes +ordr:r+
    #
    # @option params [Boolean] :paginated
    # @option params [Integer] :size the page size
    # @option params [Integer] :page the page number
    #
    # @return [OpenStruct]
    #
    # @example
    #   @orders = session.orders.all(size: 100, page: 0)
    #
    def all(params = {})
      path = "/orders"

      handle_all_request(path, :orders, params)
    end

    #
    # A +POST+ request is used to cancel an order.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/orders/e3f9264a-395b-407d-9036-00f38f609be6/cancel' -i -X POST \
    #       -H 'Content-Type: application/json' \
    #       -H 'Accept: application/hal+json' \
    #       -H 'Authorization: Bearer <Access token>' \
    #       -d '{
    #       "comment" : "This needs to be done fast!"
    #   }'
    #
    # @beyond_api.scopes +clpr:c+
    #
    # @param order_id [String] the order UUID
    # @param body [Hash] the request body
    #
    # @return [OpenStruct]
    #
    # @example
    #   body = {
    #     "comment"=> "This needs to be done fast!"
    #   }
    #   @order = session.orders.cancel("e3f9264a-395b-407d-9036-00f38f609be6", body)
    #
    def cancel(order_id, body)
      path = "/orders/#{order_id}/cancel"

      response, status = BeyondApi::Request.post(@session,
                                                 path,
                                                 body)

      handle_response(response, status)
    end

    #
    # A +GET+ request is used to retrieve the cancelation process details of an order.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/orders/f16cf0db-7449-4029-a886-76f38b4aa464/processes/cancelations/365b4b63-45a8-49f6-94c5-a65e0dee83b5' -i -X GET \
    #       -H 'Content-Type: application/json' \
    #       -H 'Accept: application/hal+json' \
    #       -H 'Authorization: Bearer <Access token>'
    #
    # @beyond_api.scopes +clpr:r+
    #
    # @param order_id [String] the order UUID
    # @param cancelation_id [String] the cancelation UUID
    #
    # @return [OpenStruct]
    #
    # @example
    #   @pcancelation_process = session.orders.cancelation_process("f16cf0db-7449-4029-a886-76f38b4aa464", "365b4b63-45a8-49f6-94c5-a65e0dee83b5")
    #
    def cancelation_process(order_id, cancelation_id)
      path = "/orders/#{order_id}/processes/payments/cancelations/#{cancelation_id}"

      response, status = BeyondApi::Request.get(@session,
                                                path)

      handle_response(response, status)
    end

    #
    # A +GET+ request is used to list all cancelation processes of an order in a paged way.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/orders/b8cb904d-4c82-4c39-a3a4-de7cb181a5d3/processes/cancelations?page=0&size=20' -i -X GET \
    #       -H 'Content-Type: application/json' \
    #       -H 'Accept: application/hal+json' \
    #       -H 'Authorization: Bearer <Access token>'
    #
    # @beyond_api.scopes +clpr:r+
    #
    # @param order_id [String] the order UUID
    # @option params [Integer] :size the page size
    # @option params [Integer] :page the page number
    #
    # @return [OpenStruct]
    #
    # @example
    #   @pcancelation_processes = session.orders.cancelation_processes("b8cb904d-4c82-4c39-a3a4-de7cb181a5d3", {page: 0, size: 20})
    #
    def cancelation_processes(order_id, params = {})
      path = "/orders/#{order_id}/processes/payments/cancelations"

      response, status = BeyondApi::Request.get(@session,
                                                path,
                                                params)

      handle_response(response, status)
    end

    #
    # A +POST+ request is used to capture the payment.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/orders/ebfd99d6-f025-4c97-96d2-d5adbb45d6c2/processes/payments/2936deca-fd56-4c0d-88e2-8030c897bf90/capture' -i -X POST \
    #       -H 'Accept: application/hal+json' \
    #       -H 'Authorization: Bearer <Access token>'
    #
    # @beyond_api.scopes +pypr:u+
    #
    # @param order_id [String] the order UUID
    # @param payment_id [String] the payment UUID
    #
    # @return [OpenStruct]
    #
    # @example
    #   @payment_process = session.orders.capture_payment_process("ebfd99d6-f025-4c97-96d2-d5adbb45d6c2", "2936deca-fd56-4c0d-88e2-8030c897bf90")
    #
    def capture_payment_process(order_id, payment_id)
      path = "/orders/#{order_id}/processes/payments/#{payment_id}/capture"

      response, status = BeyondApi::Request.post(@session,
                                                 path)

      handle_response(response, status)
    end

    #
    # A +POST+ request is used to create a new cancelation process for an order. Cancelation processes trigger a refund process.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/orders/9072c00d-1bc7-4fd8-8836-94ada5084e7a/processes/cancelations' -i -X POST \
    #       -H 'Content-Type: application/json' \
    #       -H 'Accept: application/hal+json' \
    #       -H 'Authorization: Bearer <Access token>' \
    #       -d '{
    #     "comment" : "This needs to be done fast!",
    #     "lineItems" : [ {
    #       "quantity" : 3,
    #       "productLineItemId" : "0e1f8ab4-ec78-42a6-9a46-a3384cd17d52"
    #     } ]
    #   }'
    #
    # @beyond_api.scopes +clpr:c+
    #
    # @param order_id [String] the order UUID
    # @param body [Hash] the request body
    #
    # @return [OpenStruct]
    #
    # @example
    #   body = {
    #     "comment"=> "This needs to be done fast!",
    #     "lineItems"=> [{
    #       "quantity"=> 3,
    #       "productLineItemId"=> "0e1f8ab4-ec78-42a6-9a46-a3384cd17d52"
    #     }]
    #   }
    #   @cancelation_process = session.orders.create_cancelation_process("9072c00d-1bc7-4fd8-8836-94ada5084e7a", body)
    #
    def create_cancelation_process(order_id, body)
      path = "/orders/#{order_id}/processes/payments/cancelations"

      response, status = BeyondApi::Request.post(@session,
                                                 path,
                                                 body)

      handle_response(response, status)
    end

    #
    # A +POST+ request is used to create an invoice for the order.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/orders/a5d4d6c6-e77d-4180-8dbf-729f38a698b2/create-invoice' -i -X POST \
    #       -H 'Content-Type: application/json' \
    #       -H 'Accept: application/hal+json' \
    #       -H 'Authorization: Bearer <Access token>' \
    #       -d '{"deliveryDateNote": "Test DeliveryDateNote", "invoiceNote": "Test invoiceNote"}'
    #
    # @beyond_api.scopes +ordr:u+
    #
    # @param order_id [String] the order UUID
    # @param body [Hash] the request body
    #
    # @return [OpenStruct]
    #
    # @example
    #   body = {
    #     "deliveryDateNote" => "Test DeliveryDateNote",
    #     "invoiceNote" => "Test invoiceNote"
    #   }
    #   @order = session.orders.create_invoice("a5d4d6c6-e77d-4180-8dbf-729f38a698b2", body)
    #
    def create_invoice(order_id, body)
      path = "/orders/#{order_id}/create-invoice"

      response, status = BeyondApi::Request.put(@session,
                                                path,
                                                body)

      handle_response(response, status)
    end

    #
    # A +POST+ request is used to create a new return process for an order. Return processes trigger a refund process.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/orders/29007bb7-739a-46f5-8c70-4e1029b52fa5/processes/returns' -i -X POST \
    #       -H 'Content-Type: application/json' \
    #       -H 'Accept: application/hal+json' \
    #       -H 'Authorization: Bearer <Access token>' \
    #       -d '{
    #     "comment" : "This needs to be done fast!",
    #     "sendMail" : true,
    #     "lineItems" : [ {
    #       "quantity" : 3,
    #       "productLineItemId" : "bb9ad011-6417-4f04-8bc2-39651edebd2f",
    #       "status" : "RETURNED"
    #     } ],
    #     "shippingPriceRefund" : {
    #       "currency" : "EUR",
    #       "amount" : 19.99
    #     }
    #   }'
    #
    # @beyond_api.scopes +rtpr:c+
    #
    # @param order_id [String] the order UUID
    # @param body [Hash] the request body
    #
    # @return [OpenStruct]
    #
    # @example
    #   body = {
    #     "comment": "This needs to be done fast!",
    #     "sendMail": true,
    #     "lineItems": [{
    #       "quantity": 3,
    #       "productLineItemId": "bb9ad011-6417-4f04-8bc2-39651edebd2f",
    #       "status": "RETURNED"
    #     }],
    #     "shippingPriceRefund": {
    #       "currency": "EUR",
    #       "amount": 19.99
    #     }
    #   }
    #   @return_process = session.orders.create_return_process("29007bb7-739a-46f5-8c70-4e1029b52fa5", body)
    #
    def create_return_process(order_id, body)
      path = "/orders/#{order_id}/processes/returns"

      response, status = BeyondApi::Request.post(@session,
                                                 path,
                                                 body)

      handle_response(response, status)
    end

    #
    # A +POST+ request is ussed to create a new shipping processes for an order.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/orders/8df2fe3b-5149-492f-932a-073f012305eb/processes/shippings' -i -X POST \
    #       -H 'Content-Type: application/json' \
    #       -H 'Accept: application/hal+json' \
    #       -H 'Authorization: Bearer <Access token>' \
    #       -d '{
    #     "comment" : "This needs to be done fast!",
    #     "sendMail" : true,
    #     "createPackingSlip" : true,
    #     "trackingCode" : "lookAtMyTrackingCodeWow",
    #     "trackingLink" : "http://tracking.is/fun?code=lookAtMyTrackingCodeWow",
    #     "lineItems" : [ {
    #       "quantity" : 3,
    #       "productLineItemId" : "e96e1b33-d9e9-4508-862a-816235b541f7"
    #     } ]
    #   }'
    #
    # @beyond_api.scopes +shpr:c+
    #
    # @param order_id [String] the order UUID
    # @param body [Hash] the request body
    #
    # @return [OpenStruct]
    #
    # @example
    #   body = {
    #     "comment" => "This needs to be done fast!",
    #     "send_mail" => true,
    #     "create_packing_slip" => true,
    #     "tracking_code" => "lookAtMyTrackingCodeWow",
    #     "tracking_link" => "http=>//tracking.is/fun?code=lookAtMyTrackingCodeWow",
    #     "line_items" => [ {
    #       "quantity" => 3,
    #       "product_line_item_id" => "e96e1b33-d9e9-4508-862a-816235b541f7"
    #     } ]
    #   }
    #   @shipping_process = session.orders.create_shipping_process("8df2fe3b-5149-492f-932a-073f012305eb", body)
    #
    def create_shipping_process(order_id, body)
      path = "/orders/#{order_id}/processes/shippings"

      response, status = BeyondApi::Request.post(@session,
                                                 path,
                                                 body)

      handle_response(response, status)
    end

    #
    # A +GET+ request is used to list all events of an order in a paged way.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/orders/66b6aab5-2ed4-4f36-855e-3adb2ea873ee/events' -i -X GET \
    #       -H 'Accept: application/hal+json' \
    #       -H 'Authorization: Bearer <Access token>'
    #
    # @beyond_api.scopes +ordr:r+
    #
    # @param order_id [String] the order UUID
    # @option params [Integer] :size the page size
    # @option params [Integer] :page the page number
    #
    # @return [OpenStruct]
    #
    # @example
    #   @events = session.orders.find("66b6aab5-2ed4-4f36-855e-3adb2ea873ee", { size: 100, page: 0 })
    #
    def events(order_id, params = {})
      path = "/orders/#{order_id}/events"

      response, status = BeyondApi::Request.get(@session,
                                                path,
                                                params)

      handle_response(response, status)
    end

    #
    # A +GET+ request is used to retrieve the details of an order.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/orders/a27f1019-3690-40d1-bd9d-d60dff4c4cf8' -i -X GET \
    #       -H 'Content-Type: application/json' \
    #       -H 'Accept: application/hal+json' \
    #       -H 'Authorization: Bearer <Access token>'
    #
    # @beyond_api.scopes +ordr:r+
    #
    # @param order_id [String] the order UUID
    #
    # @return [OpenStruct]
    #
    # @example
    #   @order = session.orders.find("a27f1019-3690-40d1-bd9d-d60dff4c4cf8")
    #
    def find(order_id)
      path = "/orders/#{order_id}"

      response, status = BeyondApi::Request.get(@session,
                                                path)

      handle_response(response, status)
    end

    #
    # A +POST+ request is used to mark the payment process as paid.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/orders/9a1a1aaa-e37d-4c71-bc95-cbc228463fec/processes/payments/cb8c9a16-2d81-4ec1-9a4a-84a4c36124ae/mark-paid' -i -X POST \
    #       -H 'Content-Type: application/json' \
    #       -H 'Accept: application/hal+json' \
    #       -H 'Authorization: Bearer <Access token>' \
    #       -d '{
    #          "comment" : "comment",
    #          "details" : {
    #            "amount" : {
    #              "currency" : "EUR",
    #              "amount" : 77.44
    #            }
    #          }
    #        }'
    #
    # @beyond_api.scopes +pypr:u+
    #
    # @param order_id [String] the order UUID
    # @param payment_id [String] the payment UUID
    # @param body [Hash] the request body
    #
    # @return [OpenStruct]
    #
    # @example
    #   body = {
    #     "comment" => "comment",
    #     "details" => {
    #       "amount" => {
    #         "currency" => "EUR",
    #         "amount" => 77.44
    #       }
    #     }
    #   }
    #
    #   @payment_process = session.orders.mark_payment_process_as_paid("9a1a1aaa-e37d-4c71-bc95-cbc228463fec", "cb8c9a16-2d81-4ec1-9a4a-84a4c36124ae", body)
    #
    def mark_payment_process_as_paid(order_id, payment_id, body)
      path = "/orders/#{order_id}/processes/payments/#{payment_id}/mark-paid"

      response, status = BeyondApi::Request.post(@session,
                                                 path,
                                                 body)

      handle_response(response, status)
    end

    #
    # A +POST+ request is used to mark the payment process as voided.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/orders/a5558b7f-55f4-47d4-b603-9bf7eb59c05b/processes/payments/5bcc48e7-2641-42a8-a042-189ae92e9901/mark-voided' -i -X POST \
    #       -H 'Content-Type: application/json' \
    #       -H 'Accept: application/hal+json' \
    #       -H 'Authorization: Bearer <Access token>' \
    #       -d '{
    #       "comment" : "comment"
    #   }'
    #
    # @beyond_api.scopes +pypr:u+
    #
    # @param order_id [String] the order UUID
    # @param payment_id [String] the payment UUID
    # @param body [Hash] the request body
    #
    # @return [OpenStruct]
    #
    # @example
    #   body = {
    #     "comment" => "comment"
    #   }
    #
    #   @payment_process = session.orders.mark_payment_process_as_voided("a5558b7f-55f4-47d4-b603-9bf7eb59c05b", "5bcc48e7-2641-42a8-a042-189ae92e9901", body)
    #
    def mark_payment_process_as_voided(order_id, payment_id, body)
      path = "/orders/#{order_id}/processes/payments/#{payment_id}/mark-voided"

      response, status = BeyondApi::Request.post(@session,
                                                 path,
                                                 body)

      handle_response(response, status)
    end

    #
    # A +POST+ request is used to mark the refund process as paid.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/orders/60baa84c-9e11-4d55-97a9-1a7b00a0691c/processes/refunds/active/mark-paid' -i -X POST \
    #       -H 'Content-Type: application/json' \
    #       -H 'Accept: application/hal+json' \
    #       -H 'Authorization: Bearer <Access token>' \
    #       -d '{
    #       "comment" : "comment",
    #       "details" : {
    #         "amount" : {
    #           "currency" : "EUR",
    #           "amount" : 19.98
    #         }
    #       }
    #   }'
    #
    # @beyond_api.scopes +rfpr:r+
    #
    # @param order_id [String] the order UUID
    #
    # @return [OpenStruct]
    #
    # @example
    #   body = {
    #     "comment" => "comment",
    #     "details" => {
    #       "amount" => {
    #         "currency" => "EUR",
    #         "amount" => 19.98
    #       }
    #     }
    #   }
    #   @refund_process = session.orders.mark_refund_process_as_paid("60baa84c-9e11-4d55-97a9-1a7b00a0691c", body)
    #
    def mark_refund_process_as_paid(order_id)
      path = "/orders/#{order_id}/processes/refunds/active/mark-paid"

      response, status = BeyondApi::Request.post(@session,
                                                 path)

      handle_response(response, status)
    end

    #
    # A +POST+ request is used to mark the shipment as delivered.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/orders/b5642d1f-0f7f-444e-96d5-1c1d1642ea5e/processes/shippings/619d06d8-0077-4efd-b341-5103f71bfb2d/mark-delivered' -i -X POST \
    #       -H 'Content-Type: application/json' \
    #       -H 'Accept: application/hal+json' \
    #       -H 'Authorization: Bearer <Access token>' \
    #       -d '{
    #     "comment" : "comment"
    #   }'
    #
    # @beyond_api.scopes +shpr:u+
    #
    # @param order_id [String] the order UUID
    # @param shipping_id [String] the shipping UUID
    # @param body [Hash] the request body
    #
    # @return [OpenStruct]
    #
    # @example
    #   body = {
    #     "comment" => "comment",
    #   }
    #
    #   @shipping_process = session.orders.mark_shipping_process_as_delivered("b5642d1f-0f7f-444e-96d5-1c1d1642ea5e", "619d06d8-0077-4efd-b341-5103f71bfb2d", body)
    #
    def mark_shipping_process_as_delivered(order_id, shipping_process_id, body)
      path = "/orders/#{order_id}/processes/shippings/#{shipping_process_id}/mark-delivered"

      response, status = BeyondApi::Request.post(@session,
                                                 path,
                                                 body)

      handle_response(response, status)
    end

    #
    # A +POST+ request is used to mark the shipment as shipped.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/orders/dd6a7e20-16be-4509-bf83-fb8ee072ddad/processes/shippings/a0b0c4a5-0c80-47f4-98c3-0f55f4161176/mark-shipped' -i -X POST \
    #       -H 'Content-Type: application/json' \
    #       -H 'Accept: application/hal+json' \
    #       -H 'Authorization: Bearer <Access token>' \
    #       -d '{
    #     "comment" : "This needs to be done fast!",
    #     "sendMail" : true,
    #     "details" : {
    #       "trackingCode" : "lookAtMyTrackingCodeWow",
    #       "trackingLink" : "http://tracking.is/fun?code=lookAtMyTrackingCodeWow"
    #     }
    #   }'
    #
    # @beyond_api.scopes +shpr:u+
    #
    # @param order_id [String] the order UUID
    # @param shipping_id [String] the shipping UUID
    # @param body [Hash] the request body
    #
    # @return [OpenStruct]
    #
    # @example
    #   body = {
    #     "comment" => "This needs to be done fast!",
    #     "sendMail" => true,
    #     "details" => {
    #       "trackingCode" => "lookAtMyTrackingCodeWow",
    #       "trackingLink" => "http://tracking.is/fun?code=lookAtMyTrackingCodeWow"
    #     }
    #   }
    #
    #   @shipping_process = session.orders.mark_shipping_process_as_shipped("dd6a7e20-16be-4509-bf83-fb8ee072ddad", "a0b0c4a5-0c80-47f4-98c3-0f55f4161176", body)
    #
    def mark_shipping_process_as_shipped(order_id, shipping_id, body)
      path = "/orders/#{order_id}/processes/shippings/#{shipping_id}/mark-shipped"

      response, status = BeyondApi::Request.post(@session,
                                                 path,
                                                 body)

      handle_response(response, status)
    end

    #
    # A +GET+ request is used to retrieve the payment processes.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/orders/d44ed295-6a08-47ba-a288-90d4f3ba9fff/processes/payments/be56bfbd-af95-45b9-8b0e-cb0c184aaf60' -i -X GET \
    #       -H 'Content-Type: application/json' \
    #       -H 'Accept: application/hal+json' \
    #       -H 'Authorization: Bearer <Access token>'
    #
    # @beyond_api.scopes +pypr:r+
    #
    # @param order_id [String] the order UUID
    # @param payment_id [String] the payment UUID
    #
    # @return [OpenStruct]
    #
    # @example
    #   @payment_process = session.orders.payment_process("d44ed295-6a08-47ba-a288-90d4f3ba9fff", "be56bfbd-af95-45b9-8b0e-cb0c184aaf60")
    #
    def payment_process(order_id, payment_id)
      path = "/orders/#{order_id}/processes/payments/#{payment_id}"

      response, status = BeyondApi::Request.get(@session,
                                                path)

      handle_response(response, status)
    end

    #
    # A +GET+ request is used to list all payment processes of an order in a paged way.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/orders/2012b775-a706-41e0-b0f9-5142864ca4a0/processes/payments?page=0&size=20' -i -X GET \
    #       -H 'Content-Type: application/json' \
    #       -H 'Accept: application/hal+json' \
    #       -H 'Authorization: Bearer <Access token>'
    #
    # @beyond_api.scopes +pypr:r+
    #
    # @param order_id [String] the order UUID
    # @option params [Integer] :size the page size
    # @option params [Integer] :page the page number
    #
    # @return [OpenStruct]
    #
    # @example
    #   @payment_processes = session.orders.payment_processes("2012b775-a706-41e0-b0f9-5142864ca4a0", {page: 0, size: 20})
    #
    def payment_processes(order_id, params = {})
      path = "/orders/#{order_id}/processes/payments"

      response, status = BeyondApi::Request.get(@session,
                                                path,
                                                params)

      handle_response(response, status)
    end

    #
    # A +GET+ request is used to list all order processes.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/orders/934ece52-055c-4896-8d16-560f1461ea56/processes' -i -X GET \
    #       -H 'Content-Type: application/json' \
    #       -H 'Accept: application/hal+json' \
    #       -H 'Authorization: Bearer <Access token>'
    #
    # @beyond_api.scopes +ordr:r+
    #
    # @param order_id [String] the order UUID
    #
    # @return [OpenStruct]
    #
    # @example
    #   @processes = session.orders.processes("934ece52-055c-4896-8d16-560f1461ea56")
    #
    def processes(order_id)
      path = "/orders/#{order_id}/processes"

      response, status = BeyondApi::Request.get(@session,
                                                path)

      handle_response(response, status)
    end

    #
    # A +GET+ request is used to retrieve the refund processes.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/orders/801885c8-0b25-44a2-a1a4-60cbf3f9ecca/processes/refunds/4c02883f-be31-4fb2-ad0d-ccbc3678a9f5' -i -X GET \
    #       -H 'Content-Type: application/json' \
    #       -H 'Accept: application/hal+json' \
    #       -H 'Authorization: Bearer <Access token>'
    #
    # @beyond_api.scopes +rfpr:r+
    #
    # @param order_id [String] the order UUID
    # @param refund_id [String] the refund UUID
    #
    # @return [OpenStruct]
    #
    # @example
    #   @refund_process = session.orders.refund_process("801885c8-0b25-44a2-a1a4-60cbf3f9ecca", "4c02883f-be31-4fb2-ad0d-ccbc3678a9f5")
    #
    def refund_process(order_id, refund_id)
      path = "/orders/#{order_id}/processes/refunds/#{refund_id}"

      response, status = BeyondApi::Request.get(@session,
                                                path)

      handle_response(response, status)
    end

    #
    # A +GET+ request is used to list all refund processes of an order in a paged way. Refunds are triggered if either a cancelation or return process is created. See {Create cancelation processes}[http://docs.beyondshop.cloud/#resources-cancel-processes-create] and {Create return processes}[http://docs.beyondshop.cloud/#resources-return-processes-create] for more information.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/orders/6f86e42f-763e-4514-a37d-fb8f88cdc14c/processes/refunds?page=0&size=20' -i -X GET \
    #       -H 'Content-Type: application/json' \
    #       -H 'Accept: application/hal+json' \
    #       -H 'Authorization: Bearer <Access token>'
    #
    # @beyond_api.scopes +rfpr:r+
    #
    # @param order_id [String] the order UUID
    # @option params [Integer] :size the page size
    # @option params [Integer] :page the page number
    #
    # @return [OpenStruct]
    #
    # @example
    #   @refund_processes = session.orders.refund_processes("6f86e42f-763e-4514-a37d-fb8f88cdc14c", {page: 0, size: 20})
    #
    def refund_processes(order_id, params = {})
      path = "/orders/#{order_id}/processes/refunds"

      response, status = BeyondApi::Request.get(@session,
                                                path,
                                                params)

      handle_response(response, status)
    end

    #
    # A +GET+ request is used to list all return processes of an order in a paged way.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/orders/cb9927e4-60d1-4a90-b40c-f5a8e2b25301/processes/returns/910a3fde-cb23-418f-876a-694ce42245ef' -i -X GET \
    #       -H 'Content-Type: application/json' \
    #       -H 'Accept: application/hal+json' \
    #       -H 'Authorization: Bearer <Access token>'
    #
    # @beyond_api.scopes +rtpr:r+
    #
    # @param order_id [String] the order UUID
    # @param return_process_id [String] the return process UUID
    #
    # @return [OpenStruct]
    #
    # @example
    #   @return_process = session.orders.return_process("cb9927e4-60d1-4a90-b40c-f5a8e2b25301", "910a3fde-cb23-418f-876a-694ce42245ef")
    #
    def return_process(order_id, return_process_id)
      path = "/orders/#{order_id}/processes/returns/#{return_process_id}"

      response, status = BeyondApi::Request.get(@session,
                                                path)

      handle_response(response, status)
    end

    #
    # A +GET+ request is used to list all return processes of an order in a paged way.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/orders/9e26232f-aa7a-408b-8041-9439999268c5/processes/returns?page=0&size=20' -i -X GET \
    #       -H 'Content-Type: application/json' \
    #       -H 'Accept: application/hal+json' \
    #       -H 'Authorization: Bearer <Access token>'
    #
    # @beyond_api.scopes +rtpr:r+
    #
    # @param order_id [String] the order UUID
    # @option params [Integer] :size the page size
    # @option params [Integer] :page the page number
    #
    # @return [OpenStruct]
    #
    # @example
    #   @return_processes = session.orders.return_processes("9e26232f-aa7a-408b-8041-9439999268c5", {page: 0, size: 20})
    #
    def return_processes(order_id, params = {})
      path = "/orders/#{order_id}/processes/returns"

      response, status = BeyondApi::Request.get(@session,
                                                path,
                                                params)

      handle_response(response, status)
    end

    #
    # A +GET+ request is used to retrieve the details of an order by cart ID.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/orders/search/find-by-cart-id?cartId=82e859a8-7f70-4c19-83c1-ed03457b2ceb' -i -X GET \
    #       -H 'Content-Type: application/json' \
    #       -H 'Accept: application/hal+json' \
    #       -H 'Authorization: Bearer <Access token>'
    #
    # @beyond_api.scopes +ordr:r+
    #
    # @param cart_id [String] the cart UUID
    #
    # @return [OpenStruct]
    #
    # @example
    #   @order = session.orders.search_by_cart_id("82e859a8-7f70-4c19-83c1-ed03457b2ceb")
    #
    def search_by_cart_id(cart_id)
      path = "/orders/search/find-by-cart-id"

      response, status = BeyondApi::Request.get(@session,
                                                path,
                                                { cart_id: cart_id })

      handle_response(response, status)
    end

    #
    # A +GET+ request is used to retrieve the +orderNumber+ and +orderId+ of an order by cart Id. If there is no order for the given cart Id, a HTTP 404 - NOT FOUND response is returned.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/orders/search/find-order-number-by-cart-id?cartId=7f1cf6c8-7780-430f-9de0-91cbe31c4bf6' -i -X GET \
    #       -H 'Content-Type: application/json' \
    #       -H 'Accept: application/hal+json' \
    #       -H 'Authorization: Bearer <Access token>'
    #
    # @beyond_api.scopes +ordr:r+
    #
    # @param cart_id [String] the cart UUID
    #
    # @return [OpenStruct]
    #
    # @example
    #   @order = session.orders.search_order_number_by_cart_id("7f1cf6c8-7780-430f-9de0-91cbe31c4bf6")
    #
    def search_order_number_by_cart_id(cart_id)
      path = "/orders/search/find-order-number-by-cart-id"

      response, status = BeyondApi::Request.get(@session,
                                                path,
                                                { cart_id: cart_id })

      handle_response(response, status)
    end

    #
    # A +GET+ request is used to send an invoice for the order.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/orders/acc1f22f-a992-4534-be92-b378a0319fcd/send-order-document' -i -X POST \
    #       -H 'Accept: application/hal+json' \
    #       -H 'Authorization: Bearer <Access token>' \
    #       -d '{
    #       "orderDocumentUri" : "https://myshop.com/api/pdf-storage/attachments/invoice_10003.pdf?hash=9e5e2631c6f5877d64cb3d40db46ec6eb48a3a92"
    #   }'
    #
    # @beyond_api.scopes +ordr:u+
    #
    # @param order_id [String] the order UUID
    # @param order_document_uri [String] the document url
    #
    # @return [OpenStruct]
    #
    # @example
    #   @order = session.orders.send_order_document("acc1f22f-a992-4534-be92-b378a0319fcd",
    #                                               "https://myshop.com/api/pdf-storage/attachments/invoice_10003.pdf?hash=9e5e2631c6f5877d64cb3d40db46ec6eb48a3a92")
    #
    def send_order_document(order_id, order_document_uri)
      path = "/orders/#{order_id}/send-order-document"

      response, status = BeyondApi::Request.post(@session,
                                                 path,
                                                 { order_document_uri: order_document_uri })

      handle_response(response, status)
    end

    #
    # A +GET+ request is used to retrieve the shipping process details.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/orders/af42860f-2813-4130-85d9-2d315a4f802e/processes/shippings/80ebe96b-bcd5-4a34-a428-8a67ed114ce6' -i -X GET \
    #       -H 'Content-Type: application/json' \
    #       -H 'Accept: application/hal+json' \
    #       -H 'Authorization: Bearer <Access token>'
    #
    # @beyond_api.scopes +shpr:r+
    #
    # @param order_id [String] the order UUID
    # @param shipping_process_id [String] the shipping process UUID
    #
    # @return [OpenStruct]
    #
    # @example
    #   @shipping_process = session.orders.refund_process("af42860f-2813-4130-85d9-2d315a4f802e", "80ebe96b-bcd5-4a34-a428-8a67ed114ce6")
    #
    def shipping_process(order_id, shipping_process_id)
      path = "/orders/#{order_id}/processes/shippings/#{shipping_process_id}"

      response, status = BeyondApi::Request.get(@session,
                                                path)

      handle_response(response, status)
    end

    #
    # A +GET+ request is used to list all shipping processes of an order in a paged way.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/orders/d6387876-5e93-48dc-a6f3-f85893149819/processes/shippings?page=0&size=20' -i -X GET \
    #       -H 'Content-Type: application/json' \
    #       -H 'Accept: application/hal+json' \
    #       -H 'Authorization: Bearer <Access token>'
    #
    # @beyond_api.scopes +shpr:r+
    #
    # @param order_id [String] the order UUID
    # @option params [Integer] :size the page size
    # @option params [Integer] :page the page number
    #
    # @return [OpenStruct]
    #
    # @example
    #   @shipping_processes = session.orders.shipping_processes("268a8629-55cd-4890-9013-936b9b5ea14c", {page: 0, size: 20})
    #
    def shipping_processes(order_id, params = {})
      path = "/orders/#{order_id}/processes/shippings"

      response, status = BeyondApi::Request.get(@session,
                                                path,
                                                params)

      handle_response(response, status)
    end

    #
    # A +PUT+ request is used to change the customer’s billing address.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/orders/6c36e5e3-dc4c-4d00-b4e8-3fbf9a4bed14/billing-address' -i -X PUT \
    #       -H 'Content-Type: application/json' \
    #       -H 'Accept: application/hal+json' \
    #       -H 'Authorization: Bearer <Access token>' \
    #       -d '{
    #       "address" : {
    #         "salutation" : "Mrs",
    #         "gender" : "FEMALE",
    #         "company" : "Astrid Alster GmbH",
    #         "title" : null,
    #         "firstName" : "Astrid",
    #         "middleName" : "Agnes",
    #         "lastName" : "Alster",
    #         "street" : "Alsterwasserstraße",
    #         "houseNumber" : "3",
    #         "street2" : "Erdgeschoss",
    #         "addressExtension" : "Hinterhof",
    #         "postalCode" : "20999",
    #         "dependentLocality" : "Seevetal",
    #         "city" : "Alsterwasser",
    #         "country" : "DE",
    #         "state" : "Hamburg",
    #         "email" : "a.alsterh@example.com",
    #         "phone" : "(800) 555-0102",
    #         "mobile" : "(800) 555-0103",
    #         "vatId" : "DE123456789",
    #         "taxNumber" : "HRE 987654/32123/864516",
    #         "birthDate" : "1985-05-11",
    #         "displayAddressLines" : [ "Astrid Alster GmbH", "Astrid Agnes Alster", "Alsterwasserweg 2", "Erdgeschoss", "Seevetal", "20999 Alsterwasser", "Germany" ],
    #         "_id" : null
    #       },
    #       "comment" : "Updated billing address"
    #   }'
    #
    # @beyond_api.scopes +ordr:u+
    #
    # @param order_id [String] the order UUID
    # @param body [Hash] the request body
    #
    # @return [OpenStruct]
    #
    # @example
    #   body = {
    #     "address" => {
    #       "salutation" => "Mrs",
    #       "gender" => "FEMALE",
    #       "company" => "Astrid Alster GmbH",
    #       "title" => nil,
    #       "firstName" => "Astrid",
    #       "middleName" => "Agnes",
    #       "lastName" => "Alster",
    #       "street" => "Alsterwasserstraße",
    #       "houseNumber" => "3",
    #       "street2" => "Erdgeschoss",
    #       "addressExtension" => "Hinterhof",
    #       "postalCode" => "20999",
    #       "dependentLocality" => "Seevetal",
    #       "city" => "Alsterwasser",
    #       "country" => "DE",
    #       "state" => "Hamburg",
    #       "email" => "a.alsterh@example.com",
    #       "phone" => "(800) 555-0102",
    #       "mobile" => "(800) 555-0103",
    #       "vatId" => "DE123456789",
    #       "taxNumber" => "HRE 987654/32123/864516",
    #       "birthDate" => "1985-05-11",
    #       "displayAddressLines" => [ "Astrid Alster GmbH", "Astrid Agnes Alster", "Alsterwasserweg 2", "Erdgeschoss", "Seevetal", "20999 Alsterwasser", "Germany" ],
    #       "_id" => null
    #     },
    #     "comment" => "Updated billing address"
    #   }
    #   @order = session.orders.update_billing_address("6c36e5e3-dc4c-4d00-b4e8-3fbf9a4bed14", body)
    #
    def update_billing_address(order_id, body)
      path = "/orders/#{order_id}/billing-address"

      response, status = BeyondApi::Request.put(@session,
                                                path,
                                                body)

      handle_response(response, status)
    end

    #
    # A +PUT+ request is used to change the order note.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/orders/58545e43-f4ba-48e2-b0bf-e340fd64f7b8/order-note' -i -X PUT \
    #       -H 'Content-Type: application/json' \
    #       -H 'Authorization: Bearer <Access token>' \
    #       -d '{
    #       "orderNote" : "not paid yet"
    #   }'
    #
    # @beyond_api.scopes +ordr:u+
    #
    # @param order_id [String] the order UUID
    # @param order_note [String] the order note
    #
    # @return [OpenStruct]
    #
    # @example
    #   @order = session.orders.update_order_note("58545e43-f4ba-48e2-b0bf-e340fd64f7b8", "not paid yet" )
    #
    def update_order_note(order_id, order_note)
      path = "/orders/#{order_id}/order-note"

      response, status = BeyondApi::Request.put(@session,
                                                path,
                                                { order_note: order_note })

      handle_response(response, status)
    end

    #
    # A +PUT+ request is used to change the customer's shipping address.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/orders/30327fed-812f-4b70-8931-43e34d8c8181/shipping-address' -i -X PUT \
    #       -H 'Content-Type: application/json' \
    #       -H 'Accept: application/hal+json' \
    #       -H 'Authorization: Bearer <Access token>' \
    #       -d '{
    #       "address" : {
    #         "salutation" : "Mrs",
    #         "gender" : "FEMALE",
    #         "company" : "Astrid Alster GmbH",
    #         "title" : null,
    #         "firstName" : "Astrid",
    #         "middleName" : "Agnes",
    #         "lastName" : "Alster",
    #         "street" : "Alsterwasserstraße",
    #         "houseNumber" : "3",
    #         "street2" : "Erdgeschoss",
    #         "addressExtension" : "Hinterhof",
    #         "postalCode" : "20999",
    #         "dependentLocality" : "Seevetal",
    #         "city" : "Alsterwasser",
    #         "country" : "DE",
    #         "state" : "Hamburg",
    #         "email" : "a.alsterh@example.com",
    #         "phone" : "(800) 555-0102",
    #         "mobile" : "(800) 555-0103",
    #         "doorCode" : "456",
    #         "displayAddressLines" : [ "Astrid Alster GmbH", "Astrid Agnes Alster", "Alsterwasserweg 2", "Erdgeschoss", "Seevetal", "20999 Alsterwasser", "Germany" ],
    #         "_id" : null
    #       },
    #       "comment" : "Updated shipping address"
    #   }'
    # @beyond_api.scopes +ordr:u+
    #
    # @param order_id [String] the order UUID
    # @param body [Hash] the request body
    #
    # @return [OpenStruct]
    #
    # @example
    #   body = {
    #     "address" => {
    #       "salutation" => "Mrs",
    #       "gender" => "FEMALE",
    #       "company" => "Astrid Alster GmbH",
    #       "title" => nil,
    #       "firstName" => "Astrid",
    #       "middleName" => "Agnes",
    #       "lastName" => "Alster",
    #       "street" => "Alsterwasserstraße",
    #       "houseNumber" => "3",
    #       "street2" => "Erdgeschoss",
    #       "addressExtension" => "Hinterhof",
    #       "postalCode" => "20999",
    #       "dependentLocality" => "Seevetal",
    #       "city" => "Alsterwasser",
    #       "country" => "DE",
    #       "state" => "Hamburg",
    #       "email" => "a.alsterh@example.com",
    #       "phone" => "(800) 555-0102",
    #       "mobile" => "(800) 555-0103",
    #       "vatId" => "DE123456789",
    #       "taxNumber" => "HRE 987654/32123/864516",
    #       "birthDate" => "1985-05-11",
    #       "displayAddressLines" => [ "Astrid Alster GmbH", "Astrid Agnes Alster", "Alsterwasserweg 2", "Erdgeschoss", "Seevetal", "20999 Alsterwasser", "Germany" ],
    #       "_id" => null
    #     },
    #     "comment" => "Updated shipping address"
    #   }
    #   @order = session.orders.update_shipping_address("30327fed-812f-4b70-8931-43e34d8c8181", body)
    #
    def update_shipping_address(order_id, body)
      path = "/orders/#{order_id}/shipping-address"

      response, status = BeyondApi::Request.put(@session,
                                                path,
                                                body)

      handle_response(response, status)
    end
  end
end
