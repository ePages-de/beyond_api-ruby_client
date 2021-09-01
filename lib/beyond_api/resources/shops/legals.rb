# frozen_string_literal: true

require "beyond_api/utils"

module BeyondApi
  module ShopLegals
    #
    # A +GET+ request is used to retrieve a specific part of the legal content information.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/legal-content/right-of-withdrawal' -i -X GET \
    #       -H 'Content-Type: application/json' \
    #       -H 'Accept: application/json'
    #
    # @param legal_content_type [String] the legal content type
    #
    # @return [OpenStruct]
    #
    # @example
    #   @legal_content = session.shop.legal_content("right-of-withdrawal")
    #
    def legal_content(legal_content_type)
      response, status = BeyondApi::Request.get(@session,
                                                "/legal-content/#{legal_content_type}")

      handle_response(response, status)
    end

    #
    # A +GET+ request is used to retrieve the legal content of a shop.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/legal-content' -i -X GET \
    #       -H 'Content-Type: application/json' \
    #       -H 'Accept: application/json'
    #
    # @option params [Integer] :size the page size
    # @option params [Integer] :page the page number
    #
    # @return [OpenStruct]
    #
    # @example
    #   @legal_content = session.shop.legal_contents(size: 5, page: 1)
    #
    def legal_contents(params = {})
      response, status = BeyondApi::Request.get(@session,
                                                "/legal-content",
                                                params)

      handle_response(response, status)
    end

    #
    # A +GET+ request is used to retrieve the details of the legal resource.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/shop/legal' -i -X GET \
    #       -H 'Authorization: Bearer <Access token>'
    #
    # @beyond_api.scopes +legl:r+
    #
    # @return [OpenStruct]
    #
    # @example
    #   @legal_details = session.shop.legal_details
    #
    def legal_details
      response, status = BeyondApi::Request.get(@session,
                                                "/shop/legal")

      handle_response(response, status)
    end

    #
    # A +PUT+ request is used to update the content of a specific part of the legal content information. Changes on the properties type and mandatory will be ignored.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/legal-content/legal-notice' -i -X PUT \
    #       -H 'Content-Type: application/json' \
    #       -H 'Accept: application/json' \
    #       -H 'Authorization: Bearer <Access token>' \
    #       -d '{
    #     "content" : "new legal content"
    #   }'
    #
    # @beyond_api.scopes +lcnt:u+
    #
    # @param body [Hash] the request body
    #
    # @return [OpenStruct]
    #
    # @example
    #   session.shop.update_legal_content(body)
    #
    def update_legal_content(body)
      response, status = BeyondApi::Request.put(@session,
                                                "/legal-content/legal-notice",
                                                body)

      handle_response(response, status)
    end

    #
    # A +PATCH+ request is used to update a legal resource partially with json content type.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/shop/legal' -i -X PATCH \
    #       -H 'Content-Type: application/json' \
    #       -H 'Accept: application/hal+json' \
    #       -H 'Authorization: Bearer <Access token>' \
    #       -d '{
    #     "vatId" : "GB 111111111"
    #   }'
    #
    # @beyond_api.scopes +legl:u+
    #
    # @param body [Hash] the request body
    #
    # @return [OpenStruct]
    #
    # @example
    #   body = {
    #     "vat_id" => "GB 111111111"
    #   }
    #
    #   session.shop.update_legal_details(body)
    #
    def update_legal_details(body)
      response, status = BeyondApi::Request.patch(@session,
                                                  "/shop/legal",
                                                  body)

      handle_response(response, status)
    end
  end
end
