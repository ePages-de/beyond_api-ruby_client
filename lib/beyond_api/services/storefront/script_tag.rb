# frozen_string_literal: true

module BeyondApi
  module Storefront
    # @example How to instantiate a client
    #   @client = BeyondApi::Storefront::ScriptTag.new(api_url: 'https://example.com/api', access_token: 'your_token')
    class ScriptTag < BaseService
      # Retrieve all script tags.
      #
      # @see https://developer.epages.com/beyond-docs/#list_script_tags
      #
      # @param params [Hash] A customizable set of options.
      # @option params [Boolean] :only_own If set to true, only the script tags created by the client will be returned.
      #
      # @return [Hash]
      #
      # @example
      #  script_tags = @client.all
      #  script_tags = @client.all(only_own: true)
      def all(params = {})
        params.merge!(client_id: BeyondApi.configuration.client_id) if params[:only_own]

        get('script-tags', params)
      end

      # Retrieve the details of a script tag.
      #
      # @see https://developer.epages.com/beyond-docs/#show_script_tag_details
      #
      # @param id [String] The script tag id.
      #
      # @return [Hash]
      #
      # @example
      #  script_tag = @client.show('id')
      def show(id)
        get("script-tags/#{id}")
      end

      # Create a script tag.
      #
      # @see https://developer.epages.com/beyond-docs/#create_script_tag
      #
      # @param script_url [String] The URL of the script.
      #
      # @return [Hash]
      #
      # @example
      #   script_tag = @client.create('https://example.com/scripts/exampleScript.js')
      def create(script_url)
        post('script-tags', script_url:)
      end

      # Update a script tag.
      #
      # @see https://developer.epages.com/beyond-docs/#update_script_tag
      #
      # @param id [String] The script tag id.
      # @param script_url [String] The URL of the script.
      #
      # @return [Hash]
      #
      # @example
      #   script_tag = @client.update('id', 'https://example.com/scripts/otherExampleScript.js')
      def update(id, script_url)
        put("script-tags/#{id}", script_url:)
      end

      # Delete a script tag.
      #
      # @see https://developer.epages.com/beyond-docs/#delete_script_tag
      #
      # @param id [String] The script tag id.
      #
      # @return [Hash]
      #
      # @example
      #   script_tag = @client.delete('id')
      def delete(id)
        super("script-tags/#{id}")
      end
    end
  end
end
