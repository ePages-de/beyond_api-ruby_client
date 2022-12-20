# frozen_string_literal: true

require "beyond_api/utils"

module BeyondApi
  class ScriptTags < Base
    include BeyondApi::Utils

    #
    # A +GET+ request is used to retrieve a list of all script tags for a shop.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/script-tags' -i -X GET \
    #       -H 'Authorization: Bearer <Access token>'
    #
    # @option params [Boolean] :paginated
    # @option params [Integer] :size the page size
    # @option params [Integer] :page the page number
    #
    # @return [OpenStruct]
    #
    # @example
    #   @script_tags = session.script_tags.all(size: 20, page: 0)
    #
    def all(params = {})
      path = "/script-tags"

      handle_all_request(path, :script_tags, params.merge(client_id: BeyondApi.configuration.client_id))
    end

    #
    # A +GET+ request is used to retrieve a single script tag.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/script-tags/df170ab1-13ae-4955-8b51-2478246acf59' -i -X GET \
    #       -H 'Authorization: Bearer <Access token>'
    #
    # @param script_tag_id [String] the script tag UUID
    #
    # @return [OpenStruct]
    #
    # @example
    #   @script_tag = session.script_tags.find("df170ab1-13ae-4955-8b51-2478246acf59")
    #
    def find(script_tag_id)
      path = "/script-tags/#{script_tag_id}"

      response, status = BeyondApi::Request.get(@session,
                                                path)

      handle_response(response, status)
    end

    #
    # A +POST+ request is used to create a script tag.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/script-tags' -i -X POST \
    #       -H 'Content-Type: application/json' \
    #       -H 'Accept: application/hal+json' \
    #       -H 'Authorization: Bearer <Access token>' \
    #       -d '{
    #       "scriptUrl": "https://example.org/js/fancy-script.js"
    #   }'
    #
    # @beyond_api.scopes +sctg:m+
    #
    # @param script_tag_url [String] the url of the script
    #
    # @return [OpenStruct]
    #
    # @example
    #   @script_tag = session.script_tags.create("https://example.org/js/fancy-script.js")
    #
    def create(script_tag_url)
      path = "/script-tags"

      response, status = BeyondApi::Request.post(@session,
                                                 path,
                                                 { script_url: script_tag_url })

      handle_response(response, status)
    end

    #
    # A +DELETE+ request is used to delete a script tag. You can only delete a script tag created by your app.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/script-tags/4a9f7776-d74d-4311-8ddb-121bd5407520' -i -X DELETE \
    #       -H 'Authorization: Bearer <Access token>'
    #
    # @beyond_api.scopes +sctg:m+
    #
    # @param script_tag_id [String] the script tag UUID
    #
    # @return true
    #
    # @example
    #   session.script_tags.delete("4a9f7776-d74d-4311-8ddb-121bd5407520")
    #
    def delete(script_tag_id)
      path = "/script-tags/#{script_tag_id}"

      response, status = BeyondApi::Request.delete(@session,
                                                   path)

      handle_response(response, status, respond_with_true: true)
    end

    #
    # A +PUT+ request is used to update an existing script tag. You can only update a script tag created by your app.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/script-tags/d6c7b3d2-4984-4fa6-b5f2-b0f5cfc63bd3' -i -X PUT \
    #       -H 'Content-Type: application/json' \
    #       -H 'Accept: application/hal+json' \
    #       -H 'Authorization: Bearer <Access token>' \
    #       -d '{
    #     "scriptUrl": "https://example.org/scripts/someOtherScript.js"
    #   }'
    #
    # @beyond_api.scopes +sctg:m+
    #
    # @param script_tag_id [String] the script tag UUID
    # @param script_tag_url [String] the url of the script
    #
    # @return [OpenStruct]
    #
    # @example
    #   @script_tag = session.script_tags.create("https://example.org/scripts/someOtherScript.js")
    #
    def update(script_tag_id, script_tag_url)
      path = "/script-tags/#{script_tag_id}"

      response, status = BeyondApi::Request.put(@session,
                                                path,
                                                { script_url: script_tag_url })

      handle_response(response, status)
    end
  end
end
