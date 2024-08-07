module BeyondApi
  module Storefront
    class ScriptTag < BaseService
      def all(params = {})
        params.merge!(client_id: BeyondApi.configuration.client_id) if params[:only_own]

        get("script-tags", params)
      end

      def create(script_url)
        post("script-tags", script_url:)
      end

      def delete(id)
        delete("script-tags/#{id}")
      end
    end
  end
end
