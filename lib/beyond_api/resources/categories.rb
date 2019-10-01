# frozen_string_literal: true

require "beyond_api/utils"

module BeyondApi
  class Categories < Base
    include BeyondApi::Utils

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
      response, status = BeyondApi::Request.get(@session, "/categories", params)

      handle_response(response, status)
    end

    #
    # A +POST+ request is used to create a category.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/categories' -i -X POST \
    #       -H 'Content-Type: application/json' \
    #       -H 'Authorization: Bearer <Access token>' \
    #       -d '{"name":"Power Bars","label":"power-bar","type":"SMART","query":{"bool":{"filter":{"term":{"tags":"power-bar"}}}}}'
    #
    # @beyond_api.scopes +catg:c+
    #
    # @param body [Hash] the request body
    #
    # @return [OpenStruct]
    #
    # @example
    #   body = {
    #     "name" => "Power Bars",
    #     "label" => "power-bar",
    #     "type" => "SMART",
    #     "query" => { "bool" => { "filter" => { "term" : { "tags" => "power-bar" } } } }
    #   }
    #   @category = session.categories.create(body)
    #
    def create(body)
      response, status = BeyondApi::Request.post(@session, "/categories", body)

      handle_response(response, status)
    end

    #
    # A +DELETE+ request is used to delete a category.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/categories/f461fb56-1984-4ade-bd4e-007c273cc923' -i -X DELETE \
    #       -H 'Accept: application/hal+json' \
    #       -H 'Authorization: Bearer <Access token>'
    #
    # @beyond_api.scopes +catg:d+
    #
    # @param category_id [String] the category UUID
    #
    # @return true
    #
    # @example
    #   session.categories.delete("f461fb56-1984-4ade-bd4e-007c273cc923")
    #
    def delete(category_id)
      response, status = BeyondApi::Request.delete(@session, "/categories/#{category_id}")

      handle_response(response, status, respond_with_true: true)
    end

    #
    # A +GET+ request is used to retrieve the details of a category.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/categories/27a94b71-9b17-4f06-9596-fbbf4d18021f' -i -X GET \
    #       -H 'Content-Type: application/json' \
    #       -H 'Accept: application/hal+json' \
    #       -H 'Authorization: Bearer <Access token>'
    #
    # @beyond_api.scopes +catg:r+
    #
    # @param category_id [String] the category UUID
    #
    # @return [OpenStruct]
    #
    # @example
    #   @category = session.categories.find(category_id)
    #
    def find(category_id)
      response, status = BeyondApi::Request.get(@session, "/categories/#{category_id}")

      handle_response(response, status)
    end

    #
    # A +PATCH+ request is used to update a category partially with json patch content type.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/categories/49250b7a-79a8-48d0-a71c-fc417965928d' -i -X PATCH \
    #       -H 'Content-Type: application/json-patch+json' \
    #       -H 'Accept: application/hal+json' \
    #       -H 'Authorization: Bearer <Access token>' \
    #       -d '{"name":"patched name","type":"MANUAL","query":{"bool":{"filter":[{"terms":{"id":["6c449297-65fc-41aa-a49c-68a3561b33e5","6c449297-65fc-41aa-a49c-68a3561b33e6"]}}]}}}'
    #
    # @beyond_api.scopes +catg:u+
    #
    # @param category_id [String] the category UUID
    # @param body [Hash] the request body
    #
    # @return [OpenStruct]
    #
    # @example
    #   body =  {
    #     "name" => "patched name",
    #     "type" => "MANUAL",
    #     "query" => {"bool" => { "filter" => [ { "terms" => { "id" => [ "6c449297-65fc-41aa-a49c-68a3561b33e5", "6c449297-65fc-41aa-a49c-68a3561b33e6" ] } } ] } }
    #   }
    #   @category = session.categories.update("49250b7a-79a8-48d0-a71c-fc417965928d", body)
    #
    def patch(category_id, body)
      response, status = BeyondApi::Request.patch(@session, "/categories/#{category_id}", body)

      handle_response(response, status)
    end

    #
    # A PUT request is issued to update all category properties with application/json content type.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/categories/cb2058dc-871a-4e64-83ac-39a0be9e6f82' -i -X PUT \
    #       -H 'Content-Type: application/json' \
    #       -H 'Accept: application/hal+json' \
    #       -H 'Authorization: Bearer <Access token>' \
    #       -d '{"name":"updated name","label":"updated-name","type":"MANUAL","query":{"bool":{"filter":[{"terms":{"id":["6c449297-65fc-41aa-a49c-68a3561b33e5","6c449297-65fc-41aa-a49c-68a3561b33e6"]}}]}}}'
    #
    # @beyond_api.scopes +catg:u+
    #
    # @param category_id [String] the category UUID
    # @param body [Hash] the request body
    #
    # @return [OpenStruct]
    #
    # @example
    #   body = {
    #     "name" => "updated name",
    #     "label" => "updated-name",
    #     "type" => "MANUAL",
    #     "query" => { "bool" => { "filter" => [ { "terms" => { "id" => [ "6c449297-65fc-41aa-a49c-68a3561b33e5", "6c449297-65fc-41aa-a49c-68a3561b33e6" ] } } ] } }
    #   }
    #   @category = session.categories.update(category_id, body)
    #
    def update(category_id, body)
      response, status = BeyondApi::Request.put(@session, "/categories/#{category_id}", body)

      handle_response(response, status)
    end
  end
end
