# frozen_string_literal: true

module BeyondApi
  module Shop
    # @example How to instantiate a client
    #   @client = BeyondApi::Shop::Location.new(api_url: 'https://example.com/api', access_token: 'your_token')
    class Location < BaseService
      # Create a location.
      #
      # @see https://developer.epages.com/beyond-docs/#create_location
      #
      # param body [Hash] the request body
      #
      # return [hash]
      #
      # @example
      #   body = {
      #     "languageCode": "de",
      #     "storeCode": "MLC-St-Ives",
      #     "companyName": "My little Cornershop - St.Ives",
      #     "primaryPhone": "(800) 555-0102",
      #     "address": {
      #       "postalCode": "90999",
      #       "street": "Hudson Way",
      #       "houseNumber": "27",
      #       "city": "St.Ives",
      #       "country": "GB",
      #       "dependentLocality": "",
      #       "state": "Cornwall"
      #     },
      #     "googleStatus": "ACTIVE",
      #     "googlePrimaryCategory": {
      #       "categoryId": "gcid:storefood",
      #       "displayName": "Food"
      #     },
      #     "googleAdditionalCategories": [ {
      #       "displayName": "Drinks",
      #       "categoryId": "gcid:storedrinks"
      #     } ],
      #     "regularHours": {
      #       "periods": [ {
      #         "openDay": "MONDAY",
      #         "openTime": "08:00",
      #         "closeDay": "MONDAY",
      #         "closeTime": "17:00"
      #       }, {
      #         "openDay": "SATURDAY",
      #         "openTime": "10:00",
      #         "closeDay": "SATURDAY",
      #         "closeTime": "16:00"
      #       } ]
      #     },
      #     "latLng": {
      #       "latitude": 53.5847424,
      #       "longitude": 9.968901
      #     }
      #   }
      #   @client.create(body)
      def create(body)
        post('shop/locations', body)
      end

      # Retrieve a list of all locations for the current shop
      #
      # @see https://developer.epages.com/beyond-docs/#list_locations
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
        get('shop/locations', params)
      end

      # Retrieve details of a location
      #
      # @see https://developer.epages.com/beyond-docs/#show_location_details
      #
      # @param id [String] the location UUID
      #
      # @return [Hash]
      #
      # @example
      #   @client.find('869fe0f1-e5ce-491c-914e-5160a4b1cf2f')
      def find(location_id)
        get("shop/locations/#{location_id}")
      end

      # Update a location
      #
      # @see https://developer.epages.com/beyond-docs/#update_location
      #
      # @param id [String] The language UUID
      # param body [Hash] the request body
      #
      # @return [Hash]
      #
      # @example
      #   @client.update('869fe0f1-e5ce-491c-914e-5160a4b1cf2f', body)
      def update(location_id, body)
        put("shop/locations/#{location_id}", body)
      end

      # Delete a location
      #
      # @see https://developer.epages.com/beyond-docs/#delete_location
      #
      # @param id [String] The language UUID
      #
      # @return [Hash] an empty hash
      #
      # @example
      #   @client.delete('869fe0f1-e5ce-491c-914e-5160a4b1cf2f')
      def delete(location_id)
        super("shop/locations/#{location_id}")
      end
    end
  end
end
