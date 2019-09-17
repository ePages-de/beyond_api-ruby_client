# frozen_string_literal: true

require "beyond_api/utils"

module BeyondAPI
  class NewsletterTarget < Base
    include BeyondAPI::Utils

    #
    # A +POST+ request is used to create the newsletter target. Each shop can only have one newsletter target.
    # You can update this target at any time, or delete the existing one and create a new target.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/newsletter-target' -i -X POST \
    #       -H 'Content-Type: application/json' \
    #       -H 'Accept: application/hal+json' \
    #       -H 'Authorization: Bearer <Access token>' \
    #       -d '{
    #     "submitUrl": "https://example.org/cgi-bin/subscribe.php"
    #   }'
    #
    # @beyond_api.scopes +nltg:m+
    #
    # @param submit_url [String] the URL stating where to submit the newsletter
    #
    # @return [OpenStruct]
    #
    # @example
    #   session.newsletter_target.create({ submit_url: "https://example.org/cgi-bin/subscribe.php" })
    #
    def create(submit_url)
      response, status = BeyondAPI::Request.post(@session, "/newsletter-target", { submit_url: submit_url})

      handle_response(response, status)
    end

    #
    # A +DELETE+ request is used to delete the existing newsletter target.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/newsletter-target' -i -X DELETE \
    #       -H 'Authorization: Bearer <Access token>'
    #
    # @beyond_api.scopes +nltg:m+
    #
    # @return true
    #
    # @example
    #   session.newsletter_target.delete
    #
    def delete
      response, status = BeyondAPI::Request.delete(@session, "/newsletter-target")

      handle_response(response, status, respond_with_true: true)
    end

    #
    # A +GET+ request is used to retrieve the newsletter target.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/newsletter-target' -i -X GET
    #
    # @return [OpenStruct]
    #
    # @example
    #   session.newsletter_target.find
    #
    def find
      response, status = BeyondAPI::Request.get(@session, "/newsletter-target")

      handle_response(response, status)
    end

    #
    # A +PUT+ request is used to update the existing newsletter target
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/newsletter-target' -i -X PUT \
    #       -H 'Content-Type: application/json' \
    #       -H 'Accept: application/hal+json' \
    #       -H 'Authorization: Bearer <Access token>' \
    #       -d '{
    #     "submitUrl": "https://example.org/api/newsletter/subscription"
    #   }'
    #
    # @beyond_api.scopes +nltg:m+
    #
    # @param submit_url [String] the URL stating where to submit the newsletter
    #
    # @return [OpenStruct]
    #
    # @example
    #   session.newsletter_target.update({ submit_url: "https://example.org/cgi-bin/subscribe.php" })
    #
    def update(submit_url)
      response, status = BeyondAPI::Request.put(@session, "/newsletter-target", { submit_url: submit_url })

      handle_response(response, status)
    end
  end
end
