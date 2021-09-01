# frozen_string_literal: true

require "beyond_api/utils"

module BeyondApi
  class Signers < Base
    include BeyondApi::Utils

    #
    # A +GET+ request is used to list all signers.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/signers' -i -X GET \
    #        H 'Accept: application/hal+json' \
    #        H 'Authorization: Bearer <Access token>'
    #
    # @return [OpenStruct]
    #
    # @example
    #   @signers = session.signers.all
    #
    def all
      path = "/signers"

      response, status = BeyondApi::Request.get(@session,
                                                path)

      handle_response(response, status)
    end

    #
    # A +POST+ request is used to create a signer. You cannot create more than five signers.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/signers' -i -X POST \
    #       -H 'Accept: application/hal+json' \
    #       -H 'Authorization: Bearer <Access token>'
    #
    # @return [OpenStruct]
    #
    # @example
    #   @signer = session.signers.create
    #
    def create
      path = "/signers"

      response, status = BeyondApi::Request.post(@session,
                                                 path)

      handle_response(response, status)
    end

    #
    # A +DELETE+ request is used to delete a signer. If at least one signer has been created, you cannot delete the last signer.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/signers/6bb72afd-340e-439a-9990-eef2e0883e1e' -i -X DELETE \
    #       -H 'Accept: application/hal+json' \
    #       -H 'Authorization: Bearer <Access token>'
    #
    # @return [OpenStruct]
    #
    # @example
    #   session.signers.delete("6bb72afd-340e-439a-9990-eef2e0883e1e")
    #
    def delete(signer_id)
      path = "/signers/#{signer_id}"

      response, status = BeyondApi::Request.delete(@session,
                                                   path)

      handle_response(response, status, respond_with_true: true)
    end
  end
end
