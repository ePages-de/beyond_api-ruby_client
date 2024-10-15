# frozen_string_literal: true

module BeyondApi
  module Storefront
    # @example How to instantiate a client
    #   @client = BeyondApi::Storefront::ScriptTag.new(api_url: 'https://example.com/api', access_token: 'your_token')
    class ScriptTag < BaseService
      def all(params = {})
        params.merge!(client_id: BeyondApi.configuration.client_id) if params[:only_own]

        get('script-tags', params)
      end

      def create(script_url)
        post('script-tags', script_url:)
      end

      def delete(id)
        super("script-tags/#{id}") # Concerns::Connection delete method
      end
    end
  end
end
