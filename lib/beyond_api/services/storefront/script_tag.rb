module BeyondApi
  module Storefront
    class ScriptTag < BaseService
      def all(params = {})
        params.merge!(client_id: BeyondApi.configuration.client_id) if params[:only_own]

        Request.new(@session).get("script-tags", params)
      end

      def create(script_url)
        Request.new(@session).post("script-tags", script_url:)
      end

      def delete(id)
        Request.new(@session).delete("script-tags/#{id}")
      end
    end
  end
end
