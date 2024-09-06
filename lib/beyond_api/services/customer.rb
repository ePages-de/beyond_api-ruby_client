# frozen_string_literal: true

module BeyondApi
  # @example How to instantiate a client
  #   @client = BeyondApi::Customer.new(api_url: 'https://example.com/api', access_token: 'your_token')
  class Customer < BaseService
    # Retrieve the details of a customer.
    #
    # @see https://developer.epages.com/beyond-docs/#show_customer_details
    #
    # @param id [String] the customer UUID
    #
    # @return [Hash]
    #
    # @example
    #   @client.find('5afcf0ce-4e39-4b4d-88bb-82d5cc07c83a')
    def find(id)
      get("customers/#{id}")
    end

    # List all customers of the shop in a paged manner.
    #
    # @see https://developer.epages.com/beyond-docs/#list_customers
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
      fetch_all_pages('customers', params)
    end

    # Create a `COCKPIT` customer.
    #
    # @see https://developer.epages.com/beyond-docs/#create_customer
    #
    # @param body [Hash] the request body
    #
    # @return [Hash]
    #
    # @example
    #   customer_data = {
    #     billing_address: {
    #       gender: "FEMALE",
    #       company: "Astrid Alster GmbH",
    #       first_name: "Astrid",
    #       last_name: "Alster",
    #       street: "Alsterwasserweg",
    #       house_number: "2",
    #       postal_code: "20999",
    #       city: "Alsterwasser",
    #       country: "DE",
    #       state: "Hamburg",
    #       email: "a.alsterh@example.com",
    #       phone: "(800) 555-0102"
    #     },
    #     email: "a.alsterh@example.com",
    #     customer_comment: "A reliable customer",
    #     shipping_address: {
    #       company: "ePages GmbH",
    #       first_name: "Chayanne",
    #       last_name: "Team42",
    #       street: "Pilatuspool",
    #       house_number: "2",
    #       postal_code: "20999",
    #       city: "Alsterwasser",
    #       country: "DE",
    #       state: "Hamburg",
    #       email: "a.chayanne@example.com",
    #       phone: "(800) 555-0102"
    #     }
    #   }
    #   @client.create(customer_data)
    def create(body)
      post('customers', body)
    end

    # Update a customer.
    #
    # @see https://developer.epages.com/beyond-docs/#update_customer
    #
    # @param body [Hash] the request body
    #
    # @return [Hash]
    #
    # @example
    #   customer_data = {
    #     billing_address: {
    #       company: "ePages GmbH",
    #       first_name: "Chayanne",
    #       last_name: "Team42",
    #       street: "Pilatuspool",
    #       house_number: "2",
    #       postal_code: "20999",
    #       city: "Alsterwasser",
    #       country: "DE",
    #       state: "Hamburg",
    #       email: "a.chayanne@example.com",
    #       phone: "(800) 555-0102"
    #     },
    #     email: "a.alsterh@example.com",
    #     customer_comment: "A reliable customer",
    #     shipping_address: {
    #       gender: "FEMALE",
    #       company: "Astrid Alster GmbH",
    #       first_name: "Astrid",
    #       last_name: "Alster",
    #       street: "Alsterwasserweg",
    #       house_number: "2",
    #       postal_code: "20999",
    #       city: "Alsterwasser",
    #       country: "DE",
    #       state: "Hamburg",
    #       email: "a.alsterh@example.com",
    #       phone: "(800) 555-0102"
    #     }
    #   }
    #   @client.update('2bdc787e-4643-4eeb-babf-06bc1d4b1c1b', customer_data)
    def update(id, body)
      put("customers/#{id}", body)
    end

    # Delete a customer.
    #
    # @see https://developer.epages.com/beyond-docs/#delete_customer
    #
    # @param id [String] the customer UUID
    #
    # @return [Hash] an empty hash
    #
    # @example
    #   @client.delete('71b62b1d-271a-4b56-9514-77b79f8e910a')
    def delete(id)
      super("customers/#{id}") # Concerns::Connection delete method
    end

    # List all events of a customer.
    #
    # @see https://developer.epages.com/beyond-docs/#list_customer_events
    #
    # @param id [String] the customer UUID
    #
    # @return [Hash]
    #
    # @example
    #   @client.events('df184f00-2367-417f-bc23-c7f927dbf636')
    def events(id)
      get("customers/#{id}/events")
    end
  end
end
