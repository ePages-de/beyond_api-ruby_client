# frozen_string_literal: true

require "beyond_api/utils"

module BeyondAPI
  class Products::Attachments
    include BeyondAPI::Utils

    #
    # A +POST+ request is used to list all the attachments of a product.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/products/ecb997ce-79c3-4367-9373-058089a313e3/attachments' -i -X POST \
    #       -H 'Content-Type: application/hal+json' \
    #       -H 'Accept: application/hal+json' \
    #       -H 'Authorization: Bearer <Access token>' \
    #       -d '{
    #     "mimeType" : "application/pdf",
    #     "length" : 1,
    #     "label" : "Handbuch",
    #     "dataUri" : "my_document_1.pdf?hash=8a627f655c68f56dfbbf217ab7d5563281225666"
    #   }'
    #
    # @beyond_api.scopes +prod:u+
    #
    # @param product_id [String] the product UUID
    # @option params [Integer] :size the page size
    # @option params [Integer] :page the page number
    #
    # @return [OpenStruct]
    #
    # @example
    #   body = {
    #     "mimeType" => "application/pdf",
    #     "length" => 1,
    #     "label" => "Handbuch",
    #     "dataUri" => "my_document_1.pdf?hash=8a627f655c68f56dfbbf217ab7d5563281225666"
    #   }
    #   @attachment = session.products.add_attachment("fd60a63e-c4c0-496d-af49-c4ed224cca2a", body)
    #
    def add_attachment(product_id, body)
      response, status = BeyondAPI::Request.post(@session, "/products/#{product_id}/attachments", body)

      handle_response(response, status)
    end

    #
    # A +GET+ request is used to retrieve a single attachment of a product.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/products/eb11b53a-5017-4ae7-9ba1-c02c12c80b61/attachments/36933722-f13f-4ee2-858c-0835ae0a884e' -i -X GET \
    #       -H 'Content-Type: application/hal+json' \
    #       -H 'Accept: application/hal+json' \
    #       -H 'Authorization: Bearer <Access token>'
    #
    # @beyond_api.scopes +prod:r+
    #
    # @param product_id [String] the product UUID
    # @param attachment_id [String] the attachment UUID
    #
    # @return [OpenStruct]
    #
    # @example
    #   @attachment = session.products.attachment("fd60a63e-c4c0-496d-af49-c4ed224cca2a", "36933722-f13f-4ee2-858c-0835ae0a884e")
    #
    def attachment(product_id, attachment_id)
      response, status = BeyondAPI::Request.get(@session, "/products/#{product_id}/attachments/#{attachment_id}")

      handle_response(response, status)
    end

    #
    # A +GET+ request is used to list all the attachments of a product.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/products/fd60a63e-c4c0-496d-af49-c4ed224cca2a/attachments' -i -X GET \
    #       -H 'Content-Type: application/hal+json' \
    #       -H 'Accept: application/hal+json' \
    #       -H 'Authorization: Bearer <Access token>'
    #
    # @beyond_api.scopes +prod:r+
    #
    # @param product_id [String] the product UUID
    # @option params [Integer] :size the page size
    # @option params [Integer] :page the page number
    #
    # @return [OpenStruct]
    #
    # @example
    #   @attachments = session.products.attachments("fd60a63e-c4c0-496d-af49-c4ed224cca2a", size: 100, page: 0)
    #
    def attachments(product_id, params)
      response, status = BeyondAPI::Request.get(@session, "/products/#{product_id}/attachments", params)

      handle_response(response, status)
    end

    #
    # A +DELETE+ request is used to delete a product attachment
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/products/00add006-beaa-46fe-bb73-f8ebae15082d/attachments/9a44e585-571a-4253-9248-54a4c418c7e2' -i -X DELETE \
    #       -H 'Content-Type: application/hal+json' \
    #       -H 'Accept: application/hal+json' \
    #       -H 'Authorization: Bearer <Access token>'
    #
    # @beyond_api.scopes +prod:u+
    #
    # @param product_id [String] the product UUID
    # @param attachment_id [String] the attachment UUID
    #
    # @return [true]
    #
    # @example
    #   session.products.delete_attachment("fd60a63e-c4c0-496d-af49-c4ed224cca2a", "36933722-f13f-4ee2-858c-0835ae0a884e")
    #
    def delete_attachment(product_id, attachment_id)
      response, status = BeyondAPI::Request.delete(@session, "/products/#{product_id}/attachments/#{attachment_id}")

      handle_response(response, status, respond_with_true: true)
    end

  end
end
