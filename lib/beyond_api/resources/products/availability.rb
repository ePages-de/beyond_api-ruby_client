# frozen_string_literal: true

require "beyond_api/utils"

module BeyondApi
  module ProductAvailability

    #
    # A +POST+ request is used to adjust the available stock of a product.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/products/685f483e-cdda-40af-8091-d5bc31249409/availability/adjust-available-stock' -i -X POST \
    #       -H 'Content-Type: application/json' \
    #       -H 'Accept: application/hal+json' \
    #       -H 'Authorization: Bearer <Access token>' \
    #       -d '{ "relativeAmount" : -1 }'
    #
    # @beyond_api.scopes +prda:u+
    #
    # @param product_id [String] the product UUID
    # @param relative_amount [Integer] the relative amount
    #
    # @return [OpenStruct]
    #
    # @example
    #   @availability = session.products.adjust_stock_level("685f483e-cdda-40af-8091-d5bc31249409", -1)
    #
    def adjust_stock_level(product_id, relative_amount)
      response, status = BeyondApi::Request.post(@session, "/products/#{product_id}/availability/adjust-available-stock", { relative_amount: relative_amount })

      handle_response(response, status)
    end

    #
    # A +GET+ request is used to retrieve the availability of a product.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/products/fb22d408-00dc-47e3-ae58-e35769bdb428/availability' -i -X GET \
    #       -H 'Content-Type: application/json' \
    #       -H 'Accept: application/hal+json' \
    #       -H 'Authorization: Bearer <Access token>'
    #
    # @beyond_api.scopes +prda:r+
    #
    # @param product_id [String] the product UUID
    #
    # @return [OpenStruct]
    #
    # @example
    #   @availability = session.products.availability("fb22d408-00dc-47e3-ae58-e35769bdb428")
    #
    def availability(product_id)
      response, status = BeyondApi::Request.get(@session, "/products/#{product_id}/availability")

      handle_response(response, status)
    end

    #
    # A +POST+ request is used to disable purchasability for a product.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/products/6b30255e-650f-475c-b345-e7247f957689/availability/disable-purchasability' -i -X POST \
    #       -H 'Content-Type: application/json' \
    #       -H 'Accept: application/hal+json' \
    #       -H 'Authorization: Bearer <Access token>'
    #
    # @beyond_api.scopes +prda:u+
    #
    # @param product_id [String] the product UUID
    #
    # @return true
    #
    # @example
    #   session.products.disable_purchasability("6b30255e-650f-475c-b345-e7247f957689")
    #
    def disable_purchasability(product_id)
      response, status = BeyondApi::Request.post(@session, "/products/#{product_id}/availability/disable-purchasability")

      handle_response(response, status, respond_with_true: true)
    end

    #
    # A +POST+ request is used to disable stock management for a product or variation product.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/products/e966cb17-4047-4b82-ade4-33e7f0978c89/availability/disable-stock-management' -i -X POST \
    #       -H 'Content-Type: application/json' \
    #       -H 'Accept: application/hal+json' \
    #       -H 'Authorization: Bearer <Access token>'
    #
    # @beyond_api.scopes +prda:u+
    #
    # @param product_id [String] the product UUID
    #
    # @return true
    #
    # @example
    #   session.products.disable_stock_management("e966cb17-4047-4b82-ade4-33e7f0978c89")
    #
    def disable_stock_management(product_id)
      response, status = BeyondApi::Request.post(@session, "/products/#{product_id}/availability/disable-stock-management")

      handle_response(response, status, respond_with_true: true)
    end

    #
    # A +POST+ request is used to enable purchasability for a product.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/products/17e3a92b-6f3b-4415-bd8f-c9c8921a5a73/availability/enable-purchasability' -i -X POST \
    #       -H 'Content-Type: application/json' \
    #       -H 'Accept: application/hal+json' \
    #       -H 'Authorization: Bearer <Access token>'
    #
    # @beyond_api.scopes +prda:u+
    #
    # @param product_id [String] the product UUID
    #
    # @return true
    #
    # @example
    #   session.products.enable_purchasability("17e3a92b-6f3b-4415-bd8f-c9c8921a5a73")
    #
    def enable_purchasability(product_id)
      response, status = BeyondApi::Request.post(@session, "/products/#{product_id}/availability/enable-purchasability")

      handle_response(response, status, respond_with_true: true)
    end

    #
    # A +POST+ request is used to enable stock management for a product or variation product.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/products/101fa968-9bb8-4dbe-b166-3add1fc1b35e/availability/enable-stock-management' -i -X POST \
    #       -H 'Content-Type: application/json' \
    #       -H 'Accept: application/hal+json' \
    #       -H 'Authorization: Bearer <Access token>' \
    #       -d '{ "initialAvailableStock" : 100, "stockThreshold" : 2 }'
    #
    # @beyond_api.scopes +prda:u+
    #
    # @param product_id [String] the product UUID
    # @param body [Hash] the request body
    #
    # @return [OpenStruct]
    #
    # @example
    #   body = {
    #     "initial_available_stock" => 100,
    #     "stock_threshold" => 2
    #   }
    #   @availability = session.products.enable_stock_management("101fa968-9bb8-4dbe-b166-3add1fc1b35e", body)
    #
    def enable_stock_management(product_id, body)
      response, status = BeyondApi::Request.post(@session, "/products/#{product_id}/availability/enable-stock-management", body)

      handle_response(response, status)
    end

    #
    # A +POST+ request is used to update the reserve stock by changing the +stockThreshold+ value of a product or variation product (incl. all of its variations). Reserve stock refers to an inventory level that indicates that a product needs to be reordered.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/products/f74b5f57-43cc-4176-97aa-c6eb9fdeb37c/availability/update-stock-threshold' -i -X POST \
    #       -H 'Content-Type: application/json' \
    #       -H 'Accept: application/hal+json' \
    #       -H 'Authorization: Bearer <Access token>' \
    #       -d '{ "stockThreshold" : 5 }'
    #
    # @beyond_api.scopes +prda:u+
    #
    # @param product_id [String] the product UUID
    # @param stock_threshold [Integer] the stock threshold
    #
    # @return [OpenStruct]
    #
    # @example
    #   session.products.update_reserve_stock("f74b5f57-43cc-4176-97aa-c6eb9fdeb37c", { stock_threshold => 5 })
    #
    def update_reserve_stock(product_id, stock_threshold)
      response, status = BeyondApi::Request.post(@session, "/products/#{product_id}/availability/update-stock-threshold", { stock_threshold: stock_threshold })

      handle_response(response, status)
    end
  end
end
