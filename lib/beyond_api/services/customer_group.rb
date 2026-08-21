# frozen_string_literal: true

module BeyondApi
  # @example How to instantiate a client
  #   @client = BeyondApi::CustomerGroup.new(api_url: 'https://example.com/api', access_token: 'your_token')
  class CustomerGroup < BaseService
    # List all customer groups of the shop in a paged manner.
    #
    # @see https://developer.epages.com/beyond-docs/#list_customer_groups
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
      fetch_all_pages('customer-groups', params)
    end

    # Add a customer to the given list of customer groups.
    #
    # @see https://developer.epages.com/beyond-docs/#add_customer_to_customer_groups
    #
    # @param customer_id [String] the customer UUID
    # @param customer_group_ids [Array<String>] the customer group UUIDs
    #
    # @return [Hash]
    #
    # @example
    #   @client.add_customer('fb5f14ac-f274-4673-ad40-6712dfeea1ba', ['5d94fa06-f58c-4379-9714-5dc57877c186'])
    def add_customer(customer_id, customer_group_ids)
      post("customers/#{customer_id}/customer-groups", customer_group_ids)
    end
  end
end
