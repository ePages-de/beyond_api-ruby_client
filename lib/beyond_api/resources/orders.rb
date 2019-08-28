# frozen_string_literal: true

require "beyond_api/utils"

module BeyondAPI
  class Orders < Base
    include BeyondAPI::Utils

    #
    # A +GET+ request is used to list all orders of the shop in a paged way. Each item in the response represents a summary of the order data.
    #
    # @scopes +ordr:r
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
    # A +GET+ request is used to retrieve the details of an order.
    #
    # @scopes +ordr:r
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
    # A +GET+ request is used to retrieve the details of an order by cart ID.
    #
    # @scopes +ordr:r
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
    # A +PUT+ request is used to change the customer’s billing address.
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
