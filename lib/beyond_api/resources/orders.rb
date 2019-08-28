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
      response, status = BeyondAPI::Request.get(@session, "/orders/search/find-by-cart-id?cartId=#{cart_id}")

      handle_response(response, status)
    end

    #
    # A +GET+ request is used to retrieve the +orderNumber+ and +orderId+ of an order by cart Id. If there is no order for the given cart Id, a HTTP 404 - NOT FOUND response is returned..
    #
    # @param cart_id [String] the cart UUID
    #
    # @return [OpenStruct]
    #
    # @example
    #   @order = session.orders.search_by_cart_id("268a8629-55cd-4890-9013-936b9b5ea14c")
    #
    def search_order_number_by_cart_id
      response, status = BeyondAPI::Request.get(@session, "/orders/search/find-order-number-by-cart-id?cartId=#{cart_id}")

      handle_response(response, status)
    end
  end
end
