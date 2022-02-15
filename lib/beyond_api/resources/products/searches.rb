# frozen_string_literal: true

module BeyondApi
  module Products::Searches
    #
    # A +POST+ request is used to search for products by a search term. Optionally, you can also filter the search results.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/products/search' -i -X POST \
    #       -H 'Content-Type: application/hal+json;charset=UTF-8' \
    #       -H 'Accept: application/hal+json' \
    #         -H 'Authorization: Bearer <Access token>'
    #         -d '{
    #       "search" : {
    #         "term" : "Tony Highfinger, Poloshirt, Men",
    #         "category" : "NAME"
    #       },
    #       "filters" : [ {
    #         "key" : "status",
    #         "values" : [ "PUBLISHED" ]
    #       } ],
    #       "paging" : {
    #         "page" : 0,
    #         "pageSize" : 20,
    #         "sort" : {
    #           "property" : "name",
    #           "direction" : "ASC"
    #         }
    #       }
    #   }'
    #
    # @beyond_api.scopes +prod:r+
    #
    # @param body [String] the request body
    #
    # @return [OpenStruct]
    #
    # @example
    #   body = {
    #     search: {
    #       term: "Tony Highfinger, Poloshirt, Men",
    #       category: "NAME"
    #     },
    #     filters: [ {
    #       key: "status",
    #       values: [ "PUBLISHED" ]
    #     } ],
    #     paging: {
    #       page: 0,
    #       page_size: 20,
    #       sort: {
    #         property: "name",
    #         direction: "ASC"
    #       }
    #     }
    #   }
    #   @products = session.product.search(body)
    #
    def search(body)
      response, status = BeyondApi::Request.post(@session,
                                                 "/products/search",
                                                 body)

      handle_response(response, status)
    end

    #
    # A +GET+ request is used to search for a product by SKU.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/products/search/find-by-sku?sku=vino020' -i -X GET \
    #       -H 'Authorization: Bearer <Access token>'
    #
    # @beyond_api.scopes +prod:r+
    #
    # @param sku [String] the product sku to search
    #
    # @return [OpenStruct]
    #
    # @example
    #   @product = session.product.search_by_sku("vino020")
    #
    def search_by_sku(sku)
      response, status = BeyondApi::Request.get(@session, "/products/search/find-by-sku", sku: sku)

      handle_response(response, status)
    end

    #
    # A +GET+ request is used to search used tags by a starting string. All strings are sorted by usage, starting with the biggest.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/products/search/tags?startsWith=aw' -i -X GET \
    #       -H 'Authorization: Bearer <Access token>'
    #
    # @beyond_api.scopes +prod:r+
    #
    # @param starts_with [String] the tag start to search
    # @option param [Integer] :size the page size
    # @option param [Integer] :page the page numbe
    #
    # @return [OpenStruct]
    #
    # @example
    #   @tags = session.product.search_tags_starting_by("aw")
    #
    def search_tags_starting_by(starts_with, params = {})
      response, status = BeyondApi::Request.get(@session, "/products/search/tags",
                                                params.merge(starts_with: starts_with))

      handle_response(response, status)
    end
  end
end
