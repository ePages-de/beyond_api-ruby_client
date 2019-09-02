# frozen_string_literal: true

require "beyond_api/utils"

module BeyondAPI
  class ProductViewProducts < Base
    include BeyondAPI::Utils

    #
    # A +GET+ request is used to list all products.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/product-view/products' -i -X GET \
    #       -H 'Content-Type: application/json' \
    #       -H 'Accept: application/hal+json'
    #
    # @option params [Integer] :size the page size
    # @option params [Integer] :page the page number
    #
    # @return [OpenStruct]
    #
    # @example
    #   @products = session.product_view_products.all(page: 0, size: 100)
    #
    def all(params = {})
      response, status = BeyondAPI::Request.get(@session, "/product-view/products/#{product_id}")

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
    #   @product = session.product_view_products.find("e3e86c45-de19-4179-87a4-f5f7756a0294")
    #
    def find(product_id)
      response, status = BeyondAPI::Request.get(@session, "/product-view/products/#{product_id}")

      handle_response(response, status)
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
    #   @tags = session.product_view_products.search_available_tags
    #
    def search_available_tags
      response, status = BeyondAPI::Request.get(@session, "/product-view/products/search/find-available-tags")

      handle_response(response, status)
    end

    #
    # A +POST+ request is used to search for products using a query provided as request body.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/product-view/products/search/find-by-query' -i -X POST \
    #       -H 'Content-Type: application/json' \
    #       -H 'Accept: application/hal+json' \
    #       -d '{ "query": {"bool":{"filter":[{"term":{"tags":"number0"}},{"range":{"salesPrice.amount":{"lte":8.7}}},{"range":{"createdAt":{"gte":"now-1h"}}}]}}, "sort": "name.keyword"}'
    #
    # @param query [String] the hash to search
    #
    # @return [OpenStruct]
    #
    # @example
    #   body = {
    #   	"query"=> {
    #   		"bool"=> {
    #   			"filter"=> [{
    #   				"term"=> {
    #   					"tags"=> "number0"
    #   				}
    #   			}, {
    #   				"range"=> {
    #   					"salesPrice.amount"=> {
    #   						"lte"=> 8.7
    #   					}
    #   				}
    #   			}, {
    #   				"range"=> {
    #   					"createdAt"=> {
    #   						"gte"=> "now-1h"
    #   					}
    #   				}
    #   			}]
    #   		}
    #   	},
    #   	"sort"=> "name.keyword"
    #   }
    #   @products = session.product_view_products.search_by_query(body)
    #
    def search_by_query(query)
      response, status = BeyondAPI::Request.post(@session, "/product-view/products/search/find-by-query", body)

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
    #   @products = session.product_view_products.search_by_tag("number0", page: 0, size: 100)
    #
    def search_by_tag(tag, params)
      response, status = BeyondAPI::Request.get(@session, "/product-view/products/search/find-by-tags", tag: tag, params)

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
    #   @products = session.product_view_products.search_by_term("search snippet", page: 0, size: 100)
    #
    def search_by_term(term, params)
      response, status = BeyondAPI::Request.get(@session, "/product-view/products/search/find-by-term", query: term, params)

      handle_response(response, status)
    end
  end
end
