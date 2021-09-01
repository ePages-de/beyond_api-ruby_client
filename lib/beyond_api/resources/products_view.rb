# frozen_string_literal: true

require "beyond_api/utils"

module BeyondApi
  class ProductsView < Base
    include BeyondApi::Utils

    #
    # A +GET+ request is used to list all products.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/product-view/products' -i -X GET \
    #       -H 'Content-Type: application/json' \
    #       -H 'Accept: application/hal+json'
    #
    # @option params [Boolean] :paginated
    # @option params [Integer] :size the page size
    # @option params [Integer] :page the page number
    #
    # @return [OpenStruct]
    #
    # @example
    #   @products = session.products_view.all(page: 0, size: 100)
    #
    def all(params = {})
      path = "/product-view/products"

      handle_all_request(path, :products, params)
    end

    #
    # A +GET+ request is used to list all available tags.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/product-view/products/search/find-available-tags' -i -X GET \
    #       -H 'Content-Type: application/json' \
    #       -H 'Accept: application/hal+json'
    #
    # @return [OpenStruct]
    #
    # @example
    #   @tags = session.products_view.available_tags
    #
    def available_tags
      path = "/product-view/products/search/find-available-tags"

      response, status = BeyondApi::Request.get(@session,
                                                path)

      handle_response(response, status)
    end

    #
    # TODO: To be documented.
    # NOTE: 10.4 10.5 and 10.6 are the same call with different response.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/product-view/products/f75f8fb2-5a48-4d94-aad6-3d3692c06472' -i -X GET \
    #       -H 'Content-Type: application/json' \
    #       -H 'Accept: application/hal+json'
    #
    # @param product_id [String] the product UUID
    #
    # @return [OpenStruct]
    #
    # @example
    #   @product = session.products_view.find("f75f8fb2-5a48-4d94-aad6-3d3692c06472")
    #
    def find(product_id)
      path = "/product-view/products/#{product_id}"

      response, status = BeyondApi::Request.get(@session,
                                                path)

      handle_response(response, status)
    end

    #
    # A +GET+ request is used to search for products matching any tag of the list given by a client. The intention is to offer product search capabilities for a shop’s storefront.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/product-view/products/search/find-by-tags?tag=number0' -i -X GET \
    #       -H 'Content-Type: application/json' \
    #       -H 'Accept: application/hal+json'
    #
    # @param tag [String] the tag to search
    # @option params [Integer] :size the page size
    # @option params [Integer] :page the page number
    #
    # @return [OpenStruct]
    #
    # @example
    #   @products = session.products_view.search_by_tag("number0", {page: 0, size: 100})
    #
    def search_by_tag(tag, params = {})
      path = "/product-view/products/search/find-by-tags"

      response, status = BeyondApi::Request.get(@session,
                                                path,
                                                params.merge(tag: tag))

      handle_response(response, status)
    end

    #
    # A +GET+ request is used to search for products matching any tag of the list given by a client. The intention is to offer product search capabilities for a shop’s storefront.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/product-view/products/search/find-by-term?query=search+snippet' -i -X GET \
    #       -H 'Content-Type: application/json' \
    #       -H 'Accept: application/hal+json'
    #
    # @param term [String] the term to search
    # @option params [Integer] :size the page size
    # @option params [Integer] :page the page number
    #
    # @return [OpenStruct]
    #
    # @example
    #   @products = session.products_view.search_by_term("search snippet", {page: 0, size: 100})
    #
    def search_by_term(term, params = {})
      path = "/product-view/products/search/find-by-term"

      response, status = BeyondApi::Request.get(@session,
                                                path,
                                                params.merge(query: term))

      handle_response(response, status)
    end
  end
end
