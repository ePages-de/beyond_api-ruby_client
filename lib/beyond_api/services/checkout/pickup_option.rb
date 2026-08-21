# frozen_string_literal: true

module BeyondApi
  module Checkout
    # @example How to instantiate a client
    #   @client = BeyondApi::Checkout::PickupOption.new(api_url: 'https://example.com/api', access_token: 'your_token')
    class PickupOption < BaseService
      # Create a pickup option.
      #
      # @see https://developer.epages.com/beyond-docs/#create_pickup_option
      #
      # @param body [Hash] the request body
      #
      # @return [Hash]
      #
      # @example
      #   body = {
      #     "name": "My little Cornershop - St.Ives",
      #     "description": "We will send you an email when your items are ready for pickup.",
      #     "taxClass": "REGULAR",
      #     "freePickupValue": {
      #       "currency": "EUR",
      #       "amount": 50
      #     },
      #     "fixedPrice": {
      #       "taxModel": "GROSS",
      #       "currency": "EUR",
      #       "amount": 1
      #     },
      #     "phoneNumberRequired": true,
      #     "locationId": "622d4a3c-f83d-424a-9afe-8256103f5e39"
      #   }
      #   @client.create(body)
      def create(body)
        post('pickup-options', body)
      end

      # Retrieve a list of all pickup options of the current shop.
      #
      # @see https://developer.epages.com/beyond-docs/#list_pickup_options
      #
      # @option params [Boolean] :paginated
      # @option params [Integer] :size the page size
      # @option params [Integer] :page the page number
      #
      # @return [Hash]
      #
      # @example
      #   @client.all(size: 100, page: 0)
      def all(params = {})
        fetch_all_pages('pickup-options', params)
      end

      # Retrieve the details of a pickup option.
      #
      # @see https://developer.epages.com/beyond-docs/#show_pickup_option_details
      #
      # @param pickup_option_id [String] the pickup option UUID
      #
      # @return [Hash]
      #
      # @example
      #   @client.find('1779a3ed-cb0f-4187-8cd3-e1a86114c669')
      def find(pickup_option_id)
        get("pickup-options/#{pickup_option_id}")
      end

      # Update a pickup option.
      #
      # @see https://developer.epages.com/beyond-docs/#update_pickup_option
      #
      # @param pickup_option_id [String] the pickup option UUID
      # @param body [Hash] the request body
      #
      # @return [Hash]
      #
      # @example
      #   @client.update('1779a3ed-cb0f-4187-8cd3-e1a86114c669', body)
      def update(pickup_option_id, body)
        put("pickup-options/#{pickup_option_id}", body)
      end

      # Sort the pickup options of the current shop. The request must contain the
      # pickup options of the given page in the desired order.
      #
      # @see https://developer.epages.com/beyond-docs/#sort_pickup_options
      #
      # @param pickup_option_ids [Array<String>] the pickup option UUIDs in the desired order
      #
      # @return [Hash] an empty hash
      #
      # @example
      #   @client.sort(['868be790-e76b-4073-8836-6bb962db6a1f', '7e07bb88-800d-431e-8956-471ef61426cd'])
      def sort(pickup_option_ids)
        uris = Array(pickup_option_ids).compact.map do |pickup_option_id|
          "#{@session.api_url}/pickup-options/#{pickup_option_id}"
        end
        put_uri_list('pickup-options', uris)
      end

      # Delete a pickup option.
      #
      # @see https://developer.epages.com/beyond-docs/#delete_pickup_option
      #
      # @param pickup_option_id [String] the pickup option UUID
      #
      # @return [Hash] an empty hash
      #
      # @example
      #   @client.delete('1779a3ed-cb0f-4187-8cd3-e1a86114c669')
      def delete(pickup_option_id)
        super("pickup-options/#{pickup_option_id}")
      end
    end
  end
end
