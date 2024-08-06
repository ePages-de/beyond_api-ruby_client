module BeyondApi
  module Storefront
    class ScriptTag < BaseService
      def all(params = {})
        params.merge!(client_id: BeyondApi.configuration.client_id) if params[:only_own]

        Request.get(@session, "/script-tags", params)
      end

      def create(script_url)
        Request.post(@session, "/script-tags", script_url:)
      end

      def delete(id)
        Request.delete(@session, "/script-tags/#{id}")
      end
    end
  end
end
