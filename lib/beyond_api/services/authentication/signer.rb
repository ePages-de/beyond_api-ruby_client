module BeyondApi
  module Authentication
    class Signer < BaseService
      def all(params = {})
        get("signers", params)
      end

      def create
        post("signers")
      end

      def delete(id)
        super("signers/#{id}") # Concerns::Connection delete method
      end
    end
  end
end
