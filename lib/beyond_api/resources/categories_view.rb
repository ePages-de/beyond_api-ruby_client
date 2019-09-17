# frozen_string_literal: true

require "beyond_api/utils"

module BeyondAPI
  class CategoriesView < Base
    include BeyondAPI::Utils

    #
    # A +GET+ request is used to list all product categories.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/product-view/categories' -i -X GET \
    #       -H 'Content-Type: application/json' \
    #       -H 'Accept: application/hal+json'
    #
    #
    # @option params [Integer] :size the page size
    # @option params [Integer] :page the page number
    #
    # @return [OpenStruct]
    #
    # @example
    #   @categories = session.categories_view.all(size: 100, page: 0)
    #
    def all(params = {})
      response, status = BeyondAPI::Request.get(@session, "/product-view/categories", params)

      handle_response(response, status)
    end

    #
    # A +GET+ request is used to retrieve the details of a product category.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/product-view/categories/23bb1430-6e82-40e4-9a92-4cb404da74a8' -i -X GET \
    #       -H 'Content-Type: application/json' \
    #       -H 'Accept: application/hal+json'
    #
    # @param category_id [String] the category UUID
    #
    # @return [OpenStruct]
    #
    # @example
    #   @category = session.categories_view.find("23bb1430-6e82-40e4-9a92-4cb404da74a8")
    #
    def find(category_id)
      response, status = BeyondAPI::Request.get(@session, "/product-view/categories/#{category_id}")

      handle_response(response, status)
    end

    #
    # A +GET+ request is used to list all products of a category.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/product-view/categories/681beef2-cd3e-4ce3-8034-4d07c1184447/products' -i -X GET \
    #       -H 'Content-Type: application/json' \
    #       -H 'Accept: application/hal+json'
    #
    # @param category_id [String] the category UUID
    # @option params [Integer] :size the page size
    # @option params [Integer] :page the page number
    #
    # @return [OpenStruct]
    #
    # @example
    #   @products = session.categories_view.products("681beef2-cd3e-4ce3-8034-4d07c1184447", { size: 100, page: 0 })
    #
    def products(category_id, params = {})
      response, status = BeyondAPI::Request.get(@session, "/product-view/categories/#{category_id}/products", params)

      handle_response(response, status)
    end

    #
    # A +GET+ request is used to find a product category by its unique label.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/product-view/categories/search/find-by-label?label=power-bar' -i -X GET \
    #       -H 'Content-Type: application/json' \
    #       -H 'Accept: application/hal+json'
    #
    # @param label [String] the label of the category
    #
    # @return [OpenStruct]
    #
    # @example
    #   @category = session.categories_view.search_by_label("power-bar")
    #
    def search_by_label(label)
      response, status = BeyondAPI::Request.get(@session, "/product-view/categories/search/find-by-label", { label: label })

      handle_response(response, status)
    end

    #
    # A +GET+ request is used to list all product categories a product is part of using the request parameter productId.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/product-view/categories/search/find-by-product?productId=ba68427f-603c-4741-9185-3b379f7769b5' -i -X GET \
    #       -H 'Content-Type: application/json' \
    #       -H 'Accept: application/hal+json'
    #
    # @param product_id [String] the product UUID of the category
    #
    # @return [OpenStruct]
    #
    # @example
    #   @category = session.categories_view.search_by_product_id("ba68427f-603c-4741-9185-3b379f7769b5")
    #
    def search_by_product_id(product_id, params = {})
      response, status = BeyondAPI::Request.get(@session, "/product-view/categories/search/find-by-product", params.merge(product_id: product_id))

      handle_response(response, status)
    end

    #
    # A +POST+ request is used to search for categories a new product will be part of using the request body. An existing product can also be part of the call. This endpoint can handle all properties a product can have.
    # This request is read-only and cannot create data.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/product-view/categories/search/find-by-product' -i -X POST \
    #       -H 'Content-Type: application/json' \
    #       -H 'Accept: application/hal+json'
    #       -d '{
    #     "tags" : [ "books" ],
    #     "manufacturer" : "The Standard Manufacturer",
    #     "salesPrice" : {
    #       "amount" : 10.0,
    #       "currency" : "EUR"
    #     }
    #   }'
    #
    # @param product_id [String] the product UUID of the category
    #
    # @return [OpenStruct]
    #
    # @example
    #   @category = session.categories_view.search_by_product_id("ba68427f-603c-4741-9185-3b379f7769b5")
    #
    def search_by_product(body, params = {})
      response, status = BeyondAPI::Request.post(@session, "/product-view/categories/search/find-by-product", body, params)

      handle_response(response, status = {})
    end
  end
end
