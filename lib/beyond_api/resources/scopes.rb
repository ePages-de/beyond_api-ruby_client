# frozen_string_literal: true

require "beyond_api/utils"

module BeyondAPI
  class Scopes < Base
    include BeyondAPI::Utils

    #
    # A +GET+ request will list all scopes in the system.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/scopes' -i -X GET \
    #       -H 'Authorization: Bearer <Access token>'
    #
    # @beyond_api.scopes +scop:r+
    #
    # @option params [Integer] :size the page size
    # @option params [Integer] :page the page number

    # @return [OpenStruct]
    #
    # @example
    #   @scopes = session.scopes.all(size: 20, page: 0)
    #
    def all(params = {})
      response, status = BeyondAPI::Request.get(@session, "/scopes", params)

      handle_response(response, status)
    end
  end
end
