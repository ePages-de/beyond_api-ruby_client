# frozen_string_literal: true

module BeyondApi
  module Authentication
    # @example How to instantiate a client
    #   @client = BeyondApi::Authentication::Signer.new(api_url: 'https://example.com/api', access_token: 'your_token')
    class Signer < BaseService
      # List all signers.
      #
      # @see https://developer.epages.com/beyond-docs/#list_signers
      #
      # @return [Hash]
      #      #
      # @example
      #   @client.all
      def all
        get('signers')
      end

      # Create a signer.
      #
      # @see https://developer.epages.com/beyond-docs/#create_signer
      #
      # @return [Hash]
      #
      # @example
      #   @client.create
      def create
        post('signers')
      end

      # Delete a signer. If at least one signer has been created, you cannot delete the last signer.
      #
      # @see https://developer.epages.com/beyond-docs/#delete_signer
      #
      # @return [Hash]
      #
      # @example
      #   @client.delete('aa859c3c-702c-4310-9b23-638fbc468f33')
      def delete(id)
        super("signers/#{id}") # Concerns::Connection delete method
      end
    end
  end
end
