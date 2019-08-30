# frozen_string_literal: true

require "beyond_api/utils"

module BeyondAPI
  class Products::Availability
    include BeyondAPI::Utils

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
      response, status = BeyondAPI::Request.get(@session, "/products/#{product_id}/availability")

      handle_response(response, status)
    end

    #
    # A +POST+ request is used to enable stock management for a product or variation product.
    #
    # @beyond_api.scopes +prda:u+
    #
    # POST /products/fa69c896-1c1e-4103-8acf-4ecc29c66025/availability/enable-stock-management
    # @param product_id [String] the product UUID
    #
    # @return
    #
    # @example
    #session.products.enable_stock_management(product_id, body)


    #
    # A +POST+ request is used to disable stock management for a product or variation product.
    #
    # POST /products/c8974f6d-2500-410e-a369-b1aa56f5a825/availability/disable-stock-management
    # @param product_id [String] the product UUID
    #
    # @return
    #
    # @example
    #session.products.disable_stock_management(product_id)


    #
    # A +POST+ request is used to adjust the available stock of a product.
    #
    # POST /products/96821431-0efe-444c-afd1-2de16723f830/availability/adjust-available-stock
    # @param product_id [String] the product UUID
    #
    # @return
    #
    # @example
    #session.products.adjust_stock_level(product_id, body)


    #
    # Reserve stock refers to an inventory level that indicates that a product needs to be reordered. A +POST+ request is used to update this reserve stock by changing the +stockThreshold+ value of a product or variation product (incl. all of its variations).
    #
    # POST /products/48277de8-9866-4eb8-8eb5-bcff85dc2124/availability/update-stock-threshold
    # @param product_id [String] the product UUID
    #
    # @return
    #
    # @example
    #session.products.update_reserve_stock(product_id, body)


    #
    # A +POST+ request is used to enable purchasability for a product.
    #
    # POST /products/e00ac1c3-7431-4379-b5f3-c990d2095bdd/availability/enable-purchasability
    # @param product_id [String] the product UUID
    #
    # @return
    #
    # @example
    #session.products.enable_purchasability(product_id)


    #
    # A +POST+ request is used to disable purchasability for a product.
    #
    # POST /products/cf4cb507-1e47-4cbc-927f-7d7d9f86695e/availability/disable-purchasability
    # @param product_id [String] the product UUID
    #
    # @return
    #
    # @example
    #session.products.disable_purchasability(product_id)

  end
end
