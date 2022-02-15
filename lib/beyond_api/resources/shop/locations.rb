# frozen_string_literal: true

module BeyondApi
  module Shop::Locations
    #
    # A +GET+ request is used to retrieve a list of all locations for the current shop.
    #
    #   $ curl 'https://yourshop.api.urn/shop/locations' -i -X GET \
    #       -H 'Accept: application/hal+json' \
    #       -H 'Authorization: Bearer <Access token>'
    #
    # @beyond_api.scopes +loca:r+
    #
    # @option params [Boolean] :paginated
    # @option params [Integer] :size the page size
    # @option params [Integer] :page the page number
    #
    # @return [OpenStruct]
    #
    # @example
    #   @locations = session.shop.locations(size: 100, page: 0)
    #
    def locations(params = {})
      handle_all_request("/shop/locations", :locations, params)
    end

    #
    # A +POST+ request is used to create a location.
    #
    #   $ curl 'https://yourshop.api.urn/shop/locations' -i -X POST \
    #       -H 'Content-Type: application/json;charset=UTF-8' \
    #       -H 'Accept: application/hal+json' \
    #       -H 'Authorization: Bearer <Access token>' \
    #       -d '{
    #     "languageCode" : "de",
    #     "storeCode" : "",
    #     "locationName" : "HealthyThings",
    #     "primaryPhone" : "01522 3097093",
    #     "address" : {
    #       "locality" : "Hamburg",
    #       "postalCode" : "20253",
    #       "regionCode" : "DE",
    #       "addressLines" : [ "Pilatuspool 2", "ePages GmbH" ]
    #     },
    #     "primaryCategory" : {
    #       "categoryId" : "gcid:store",
    #       "displayName" : "Geschaeft"
    #     },
    #     "websiteUrl" : "",
    #     "regularHours" : {
    #       "periods" : [ {
    #         "openDay" : "MONDAY",
    #         "openTime" : "18:00",
    #         "closeDay" : "TUESDAY",
    #         "closeTime" : "03:00"
    #       }, {
    #         "openDay" : "WEDNESDAY",
    #         "openTime" : "17:00",
    #         "closeDay" : "WEDNESDAY",
    #         "closeTime" : "23:00"
    #       } ]
    #     },
    #     "latLng" : {
    #       "latitude" : 53.5847424,
    #       "longitude" : 9.968901
    #     }
    #   }'
    #
    # @beyond_api.scopes +loca:c+
    #
    # @param body [Hash] the request body
    #
    # @return [OpenStruct]
    #
    # @example
    #   body = {
    #     "languageCode" => "de",
    #     "storeCode" => "",
    #     "locationName" => "HealthyThings",
    #     "primaryPhone" => "01522 3097093",
    #     "address" => {
    #       "locality" => "Hamburg",
    #       "postalCode" => "20253",
    #       "regionCode" => "DE",
    #       "addressLines" => [ "Pilatuspool 2", "ePages GmbH" ]
    #     },
    #     "primaryCategory" => {
    #       "categoryId" => "gcid:store",
    #       "displayName" => "Geschaeft"
    #     },
    #     "websiteUrl" => "",
    #     "regularHours" => {
    #       "periods" => [ {
    #         "openDay" => "MONDAY",
    #         "openTime" => "18:00",
    #         "closeDay" => "TUESDAY",
    #         "closeTime" => "03:00"
    #       }, {
    #         "openDay" => "WEDNESDAY",
    #         "openTime" => "17:00",
    #         "closeDay" => "WEDNESDAY",
    #         "closeTime" => "23:00"
    #       } ]
    #     },
    #     "latLng" : {
    #       "latitude" => 53.5847424,
    #       "longitude" => 9.968901
    #     }
    #   }
    #   @location = session.shop.create_location(body)
    #
    def create_location(body)
      response, status = BeyondApi::Request.post(@session, "/shop/locations", body)

      handle_response(response, status)
    end

    #
    # A +DELETE+ request is used to delete a location.
    #
    #   $ curl 'https://yourshop.api.urn/shop/locations/5bcf7c0a-d130-4cf8-af0c-5e57d4605be0' -i -X DELETE \
    #       -H 'Accept: application/hal+json' \
    #       -H 'Authorization: Bearer <Access token>'
    #
    # @beyond_api.scopes +loca:d+
    #
    # @param location_id [String] the location UUID
    #
    # @return true
    #
    # @example
    #   session.shop.delete_location("f461fb56-1984-4ade-bd4e-007c273cc923")
    #
    def delete_location(location_id)
      response, status = BeyondApi::Request.delete(@session, "/shop/locations/#{location_id}")

      handle_response(response, status, respond_with_true: true)
    end

    #
    # A +GET+ request is used to retrieve a particular location by its id.
    #
    #   $ curl 'https://yourshop.api.urn/shop/locations/09ca2715-cdf7-4af3-8b22-9ecf39d1e202' -i -X GET \
    #       -H 'Accept: application/hal+json' \
    #       -H 'Authorization: Bearer <Access token>'
    #
    # @beyond_api.scopes +loca:r+
    #
    # @param location_id [String] the location UUID
    #
    # @return [OpenStruct]
    #
    # @example
    #   @location = session.shop.location("27a94b71-9b17-4f06-9596-fbbf4d18021f")
    #
    def location(location_id)
      response, status = BeyondApi::Request.get(@session, "/shop/locations/#{location_id}")

      handle_response(response, status)
    end

    #
    # A +PUT+ request is used to update a location.
    #
    #   $ curl 'https://yourshop.api.urn/shop/locations/a7a2acfa-0243-4e52-8b56-81cb781ce61d' -i -X PUT \
    #       -H 'Content-Type: application/json;charset=UTF-8' \
    #       -H 'Accept: application/hal+json' \
    #       -H 'Authorization: Bearer <Access token>' \
    #       -d '{
    #     "languageCode" : "en",
    #     "storeCode" : "",
    #     "locationName" : "UnhealthyThings",
    #     "primaryPhone" : "01234 691997",
    #     "address" : {
    #       "locality" : "London",
    #       "postalCode" : "1",
    #       "regionCode" : "GB",
    #       "addressLines" : [ "St. James Square", "ePages Ltd" ]
    #     },
    #     "primaryCategory" : {
    #       "categoryId" : "gcid:store",
    #       "displayName" : "Shop"
    #     },
    #     "websiteUrl" : "",
    #     "regularHours" : {
    #       "periods" : [ {
    #         "openDay" : "SATURDAY",
    #         "openTime" : "06:00",
    #         "closeDay" : "SATURDAY",
    #         "closeTime" : "22:00"
    #       } ]
    #     },
    #     "latLng" : {
    #       "latitude" : 51.5072,
    #       "longitude" : -0.1353
    #     }
    #   }'
    #
    # @beyond_api.scopes +loca:u+
    #
    # @param location_id [String] the location UUID
    # @param body [Hash] the request body
    #
    # @return [OpenStruct]
    #
    # @example
    #   body = {
    #     "languageCode" => "de",
    #     "storeCode" => "",
    #     "locationName" => "HealthyThings",
    #     "primaryPhone" => "01522 3097093",
    #     "address" => {
    #       "locality" => "Hamburg",
    #       "postalCode" => "20253",
    #       "regionCode" => "DE",
    #       "addressLines" => [ "Pilatuspool 2", "ePages GmbH" ]
    #     },
    #     "primaryCategory" => {
    #       "categoryId" => "gcid:store",
    #       "displayName" => "Geschaeft"
    #     },
    #     "websiteUrl" => "",
    #     "regularHours" => {
    #       "periods" => [ {
    #         "openDay" => "MONDAY",
    #         "openTime" => "18:00",
    #         "closeDay" => "TUESDAY",
    #         "closeTime" => "03:00"
    #       }, {
    #         "openDay" => "WEDNESDAY",
    #         "openTime" => "17:00",
    #         "closeDay" => "WEDNESDAY",
    #         "closeTime" => "23:00"
    #       } ]
    #     },
    #     "latLng" : {
    #       "latitude" => 53.5847424,
    #       "longitude" => 9.968901
    #     }
    #   }
    #   @location = session.shop.update_location("27a94b71-9b17-4f06-9596-fbbf4d18021f", body)
    #
    def update_location(location_id, body)
      response, status = BeyondApi::Request.put(@session, "/shop/locations/#{location_id}", body)

      handle_response(response, status)
    end
  end
end
