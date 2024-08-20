# frozen_string_literal: true

module BeyondApi
  module Authentication
    # @example How to instantiate a client
    #   @client = BeyondApi::Authentication::Signer.new(api_url: 'https://example.com/api', access_token: 'your_token')
    class Signer < BaseService
      # List all signers
      #
      # @return [Hash]
      #
      # @see https://developer.epages.com/beyond-docs/#list_signers
      #
      # @example
      #   @client.all
      def all
        get('signers')
      end

      # Create a signer
      #
      # @return [Hash]
      #
      # @see https://developer.epages.com/beyond-docs/#create_signer
      #
      # @example
      #   @client.create
      def create
        post('signers')
      end

      # Delete a signer. If at least one signer has been created, you cannot delete the last signer.
      #
      # @return [Hash]
      #
      # @see https://developer.epages.com/beyond-docs/#delete_signer
      #
      # @example
      #   @client.delete('aa859c3c-702c-4310-9b23-638fbc468f33')
      def delete(id)
        super("signers/#{id}")
      end
    end
  end
end
