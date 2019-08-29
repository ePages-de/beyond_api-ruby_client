# frozen_string_literal: true

require "beyond_api/utils"

module BeyondAPI
  class Orders < Base
    include BeyondAPI::Utils

    #
    # A +GET+ request is used to retrieve the active payment processes. There is only one active payment process. See {Show payment process details}[http://docs.beyondshop.cloud/#resources-payment-process-get] for more information about the request and response structure.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/orders/208e2c1d-6610-43c7-b2f1-20aad6f029b9/processes/payments/active' -i -X GET \
    #       -H 'Content-Type: application/json' \
    #       -H 'Accept: application/hal+json' \
    #       -H 'Authorization: Bearer <Access token>'
    #
    # @beyond_api.scopes +pypr:r
    #
    # @param order_id [String] the order UUID
    #
    # @return [OpenStruct]
    #
    # @example
    #   @payment_process = session.orders.active_payment_process("268a8629-55cd-4890-9013-936b9b5ea14c")
    #
    def active_payment_process(order_id)
      response, status = BeyondAPI::Request.get(@session, "/orders/#{order_id}/processes/payments/active")

      handle_response(response, status)
    end

    #
    # A +GET+ request is used to list all orders of the shop in a paged way. Each item in the response represents a summary of the order data.
    #
    # @beyond_api.scopes +ordr:r
    #
    # @option params [Integer] :size the page size
    # @option params [Integer] :page the page number
    #
    # @return [OpenStruct]
    #
    # @example
    #   @orders = session.orders.all(size: 100, page: 0)
    #
    def all(params)
      response, status = BeyondAPI::Request.get(@session, "/orders", params)

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
    # @beyond_api.scopes +ordr:u
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
    #   @order = session.orders.create_invoice("268a8629-55cd-4890-9013-936b9b5ea14c", body)
    #
    def create_invoice(order_id, body)
      response, status = BeyondAPI::Request.put(@session, "/orders/#{order_id}/create-invoice", body)

      handle_response(response, status)
    end

    #
    # A +GET+ request is used to retrieve the details of an order.
    #
    # @beyond_api.scopes +ordr:r
    #
    # @param order_id [String] the order UUID
    #
    # @return [OpenStruct]
    #
    # @example
    #   @order = session.orders.find("268a8629-55cd-4890-9013-936b9b5ea14c")
    #
    def find(order_id)
      response, status = BeyondAPI::Request.get(@session, "/orders/#{order_id}")

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
    # @beyond_api.scopes +pypr:r
    #
    # @param order_id [String] the order UUID
    # @param payment_id [String] the payment UUID
    #
    # @return [OpenStruct]
    #
    # @example
    #   @payment_process = session.orders.mark_payment_process_as_voided("268a8629-55cd-4890-9013-936b9b5ea14c", "266d8608-55cd-4890-9474-296a9q1ea05q")
    #
    def mark_payment_process_as_voided(order_id, payment_id)
      response, status = BeyondAPI::Request.get(@session, "/orders/#{order_id}/processes/payments/#{payment_id}")

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
    # @beyond_api.scopes +pypr:r
    #
    # @param order_id [String] the order UUID
    # @param payment_id [String] the payment UUID
    #
    # @return [OpenStruct]
    #
    # @example
    #   @payment_process = session.orders.payment_process("268a8629-55cd-4890-9013-936b9b5ea14c", "266d8608-55cd-4890-9474-296a9q1ea05q")
    #
    def payment_process(order_id, payment_id)
      response, status = BeyondAPI::Request.get(@session, "/orders/#{order_id}/processes/payments/#{payment_id}")

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
    # @beyond_api.scopes +pypr:r
    #
    # @param order_id [String] the order UUID
    # @option params [Integer] :size the page size
    # @option params [Integer] :page the page number
    #
    # @return [OpenStruct]
    #
    # @example
    #   @payment_processes = session.orders.payment_processes("268a8629-55cd-4890-9013-936b9b5ea14c", {page: 0, size: 20})
    #
    def payment_processes(order_id, params)
      response, status = BeyondAPI::Request.get(@session, "/orders/#{order_id}/processes/payments", params)

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
    # @beyond_api.scopes +ordr:r
    #
    # @param order_id [String] the order UUID
    #
    # @return [OpenStruct]
    #
    # @example
    #   @orders = session.orders.processes("268a8629-55cd-4890-9013-936b9b5ea14c")
    #
    def processes(order_id)
      response, status = BeyondAPI::Request.get(@session, "/orders/#{order_id}/processes")

      handle_response(response, status)
    end

    #
    # A +GET+ request is used to retrieve the details of an order by cart ID.
    #
    # @beyond_api.scopes +ordr:r
    #
    # @param cart_id [String] the cart UUID
    #
    # @return [OpenStruct]
    #
    # @example
    #   @order = session.orders.search_by_cart_id("268a8629-55cd-4890-9013-936b9b5ea14c")
    #
    def search_by_cart_id(cart_id)
      response, status = BeyondAPI::Request.get(@session, "/orders/search/find-by-cart-id", {"cartId": cart_id})

      handle_response(response, status)
    end

    #
    # A +GET+ request is used to retrieve the +orderNumber+ and +orderId+ of an order by cart Id. If there is no order for the given cart Id, a HTTP 404 - NOT FOUND response is returned.
    #
    # @param cart_id [String] the cart UUID
    #
    # @return [OpenStruct]
    #
    # @example
    #   @order = session.orders.search_by_cart_id("268a8629-55cd-4890-9013-936b9b5ea14c")
    #
    def search_order_number_by_cart_id(cart_id)
      response, status = BeyondAPI::Request.get(@session, "/orders/search/find-order-number-by-cart-id", {"cartId": cart_id})

      handle_response(response, status)
    end

    #
    # A +GET+ request is used to send an invoice for the order.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/orders/73bb3fbb-7146-4088-a0d8-dd24dc030e07/send-invoice' -i -X POST \
    #       -H 'Accept: application/hal+json' \
    #       -H 'Authorization: Bearer <Access token>'
    #
    # @param order_id [String] the order_id UUID
    #
    # @return [OpenStruct]
    #
    # @example
    #   @order = session.orders.send_invoice("268a8629-55cd-4890-9013-936b9b5ea14c")
    #
    def send_invoice(order_id)
      response, status = BeyondAPI::Request.post(@session, "/orders/#{order_id}/send-invoice")

      handle_response(response, status)
    end

    #
    # A +PUT+ request is used to change the customer’s billing address.
    #
    # @beyond_api.scopes +ordr:u
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
    #   @order = session.orders.update_billing_address("268a8629-55cd-4890-9013-936b9b5ea14c", body)
    #
    def update_billing_address(order_id, body)
      response, status = BeyondAPI::Request.put(@session, "/orders/#{order_id}/billing-address", body)

      handle_response(response, status)
    end

    #
    # A +PUT+ request is used to change the order note.
    #
    # @beyond_api.scopes +ordr:u
    #
    # @param order_id [String] the order UUID
    # @param body [Hash] the request body
    #
    # @return [OpenStruct]
    #
    # @example
    #   body = {
    #     "orderNote" => "not paid yet"
    #   }
    #   @order = session.orders.update_order_note("268a8629-55cd-4890-9013-936b9b5ea14c", body)
    #
    def update_order_note(order_id, body)
      response, status = BeyondAPI::Request.put(@session, "/orders/#{order_id}/order-note", body)

      handle_response(response, status)
    end

    #
    # A +PUT+ request is used to change the customer’s shipping.
    #
    # @beyond_api.scopes +ordr:u
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
    #   @order = session.orders.update_shipping_address("268a8629-55cd-4890-9013-936b9b5ea14c", body)
    #
    def update_shipping_address(order_id, body)
      response, status = BeyondAPI::Request.put(@session, "/orders/#{order_id}/shipping-address", body)

      handle_response(response, status)
    end
  end
end
