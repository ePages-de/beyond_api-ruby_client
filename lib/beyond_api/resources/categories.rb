# frozen_string_literal: true

require "beyond_api/utils"

module BeyondAPI
  class Categories < Base
    include BeyondAPI::Utils

    #
    # A +GET+ request is used to list all available categories in a paged manner.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/categories' -i -X GET \
    #       -H 'Content-Type: application/json' \
    #       -H 'Accept: application/hal+json' \
    #       -H 'Authorization: Bearer <Access token>'
    #
    # @beyond_api.scopes +catg:r+
    #
    # @option params [Integer] :size the page size
    # @option params [Integer] :page the page number
    #
    # @return [OpenStruct]
    #
    # @example
    #   @categories = session.categories.all(size: 100, page: 0)
    #
    def all(params = {})
      response, status = BeyondAPI::Request.get(@session, "/categories", params)

      handle_response(response, status)
    end

    #
    # A +POST+ request is used to create a category
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/categories' -i -X POST \
    #       -H 'Content-Type: application/json' \
    #       -H 'Authorization: Bearer <Access token>' \
    #       -d '{"name":"Power Bars","label":"power-bar","type":"SMART","query":{"bool":{"filter":{"term":{"tags":"power-bar"}}}}}'
    #
    # @beyond_api.scopes +catg:c+
    #
    # @return [OpenStruct]
    #
    # @example
    #   @categories = session.categories.all(size: 100, page: 0)
    #
    def create(body)
      response, status = BeyondAPI::Request.post(@session, "/categories", body)

      handle_response(response, status)
    end

    def find(category_id)
      response, status = BeyondAPI::Request.get(@session, "/categories/#{category_id}")

      handle_response(response, status)
    end

    def update(category_id, body)
      response, status = BeyondAPI::Request.put(@session, "/categories/#{category_id}", body)

      handle_response(response, status)
    end

    def patch(category_id, body)
      response, status = BeyondAPI::Request.patch(@session, "/categories/#{category_id}", body)

      handle_response(response, status)
    end

    def delete(category_id)
      response, status = BeyondAPI::Request.delete(@session, "/categories/#{category_id}")

      handle_response(response, status, respond_with_true: true)
    end
  end
end
