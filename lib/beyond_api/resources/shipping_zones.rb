# frozen_string_literal: true

require "beyond_api/utils"

module BeyondAPI
  class ShippingZones < Base
    include BeyondAPI::Utils

    #
    # A +GET+ request is used to list all shipping zones in a paged way.
    #
    # @beyond_api.scopes +shpz:r+
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/shipping-zones' -i -X GET \
    #       -H 'Authorization: Bearer <Access token>'
    #
    # @option params [Integer] :size the page size
    # @option params [Integer] :page the page number
    #
    # @return [OpenStruct]
    #
    # @example
    #   @shipping_zones = session.shipping_zones.all(size: 20, page: 0)
    #
    def all(params = {})
      response, status = BeyondAPI::Request.get(@session, "/shipping-zones", params)

      handle_response(response, status)
    end

    #
    # A +POST+ request is used to create a shipping zone.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/shipping-zones' -i -X POST \
    #       -H 'Content-Type: application/json' \
    #       -H 'Authorization: Bearer <Access token>' \
    #       -d '{
    #     "name" : "BE-NL-LU",
    #     "serviceableCountries" : [ "BE", "NL", "LU" ]
    #   }'
    #
    # @beyond_api.scopes +shpz:c+
    #
    # @param body [Hash] the request body
    #
    # @return [OpenStruct]
    #
    # @example
    #   body = {
    #     "name" => "BE-NL-LU",
    #     "serviceableCountries" => [ "BE", "NL", "LU" ]
    #   }
    #   @shipping_zone = session.shipping_zones.create(body)
    #
    def create(body)
      response, status = BeyondAPI::Request.post(@session, "/shipping-zones", body)

      handle_response(response, status)
    end

    #
    # A +POST+ request is used to create a shipping method in a shipping zone.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/shipping-zones/905e981c-1489-45af-9138-0a7dc1f0b085/shipping-methods' -i -X POST \
    #       -H 'Content-Type: application/json' \
    #       -H 'Authorization: Bearer <Access token>' \
    #       -d '{
    #     "name" : "Standard Shipping 2",
    #     "description" : "Standard Shipping",
    #     "taxClass" : "REGULAR",
    #     "freeShippingValue" : {
    #       "taxModel" : "GROSS",
    #       "currency" : "EUR",
    #       "amount" : 400
    #     },
    #     "fixedPrice" : {
    #       "taxModel" : "GROSS",
    #       "currency" : "EUR",
    #       "amount" : "19.99"
    #     }
    #   }'
    #
    # @beyond_api.scopes +shpz:u+
    #
    # @param shipping_zone_id [String] the shipping zone UUID
    # @param body [Hash] the request body
    #
    # @return [OpenStruct]
    #
    # @example
    #   body = {
    #     "name" => "Standard Shipping 2",
    #     "description" => "Standard Shipping",
    #     "taxClass" => "REGULAR",
    #     "freeShippingValue" => {
    #       "taxModel" => "GROSS",
    #       "currency" => "EUR",
    #       "amount" => 400
    #     },
    #     "fixedPrice" => {
    #       "taxModel" => "GROSS",
    #       "currency" => "EUR",
    #       "amount" => "19.99"
    #     }
    #   }
    #   @shipping_zone = session.shipping_zones.create("905e981c-1489-45af-9138-0a7dc1f0b085", body)
    #
    def create_shipping_method(shipping_zone_id, body)
      response, status = BeyondAPI::Request.post(@session, "/shipping-zones/#{shipping_zone_id}/shipping-methods", body)

      handle_response(response, status)
    end

    #
    # A +DELETE+ request is used to delete a shipping zone. You cannot delete the shipping zone if it contains the last shipping method of a shop.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/shipping-zones/c871b402-b6d9-4c6d-b76c-440f61175805' -i -X DELETE \
    #       -H 'Authorization: Bearer <Access token>'
    #
    # @beyond_api.scopes +shpz:d+
    #
    # @param shipping_zone_id [String] the shipping zone UUID
    #
    # @return true
    #
    # @example
    #   session.shipping_zones.delete("c871b402-b6d9-4c6d-b76c-440f61175805")
    #
    def delete(shipping_zone_id)
      response, status = BeyondAPI::Request.delete(@session, "/shipping-zones/#{shipping_zone_id}")

      handle_response(response, status, respond_with_true: true)
    end

    #
    # A +DELETE+ request is used to delete a shipping method in a shipping zone. You cannot delete the last shipping method of a shop.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/shipping-zones/61c14c3c-ce26-4524-9713-f2ede7ff22fa/shipping-methods/d2eee203-a1c6-4035-8e7a-74bb77cfde47' -i -X DELETE \
    #       -H 'Authorization: Bearer <Access token>'
    #
    # @beyond_api.scopes +shpz:u+
    #
    # @param shipping_zone_id [String] the shipping zone UUID
    # @param shipping_method_id [String] the shipping method UUID
    #
    # @return true
    #
    # @example
    #   session.shipping_zones.delete_shipping_method("61c14c3c-ce26-4524-9713-f2ede7ff22fa", "d2eee203-a1c6-4035-8e7a-74bb77cfde47")
    #
    def delete_shipping_method(shipping_zone_id, shipping_method_id)
      response, status = BeyondAPI::Request.delete(@session, "/shipping-zones/#{shipping_zone_id}/shipping_methods/#{shipping_method_id}")

      handle_response(response, status, respond_with_true: true)
    end

    #
    # A +GET+ request is used to retrieve the details of a shipping zone.
    #
    # @beyond_api.scopes +shpz:r+
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/shipping-zones/27914098-c1f6-46aa-9e78-c7ac873e25b3' -i -X GET \
    #       -H 'Accept: application/hal+json' \
    #       -H 'Authorization: Bearer <Access token>'
    #
    # @param shipping_zone_id [String] the shipping zone UUID
    #
    # @return [OpenStruct]
    #
    # @example
    #   @shipping_zone = session.shipping_zones.find("27914098-c1f6-46aa-9e78-c7ac873e25b3")
    #
    def find(shipping_zone_id)
      response, status = BeyondAPI::Request.get(@session, "/shipping-zones/#{shipping_zone_id}")

      handle_response(response, status)
    end

    #
    # A +GET+ request is used to find the serviceable countries.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/shipping-zones/search/find-all-serviceable-countries' -i -X GET \
    #       -H 'Accept: application/hal+json'
    #
    # @return [OpenStruct]
    #
    # @example
    #   @serviceable_countries = session.shipping_zones.find_serviceable_countries
    #
    def find_serviceable_countries
      response, status = BeyondAPI::Request.get(@session, "/shipping-zones/search/find-all-serviceable-countries")

      handle_response(response, status)
    end

    # A +GET+ request is used to retrieve the details of a shipping method in a shipping zone.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/shipping-zones/61780dd6-0150-4fcf-953c-d10c52bab4ab/shipping-methods/13bd1fc9-706c-4774-923a-484a41aaab89' -i -X GET \
    #       -H 'Accept: application/hal+json' \
    #       -H 'Authorization: Bearer <Access token>'
    #
    # @beyond_api.scopes +shpz:r+
    #
    # @param shipping_zone_id [String] the shipping zone UUID
    # @param shipping_method_id [String] the shipping method UUID
    #
    # @return [OpenStruct]
    #
    # @example
    #   @shipping_method = session.shipping_zones.shipping_method("61780dd6-0150-4fcf-953c-d10c52bab4ab", "13bd1fc9-706c-4774-923a-484a41aaab89")
    #
    def shipping_method(shipping_zone_id, shipping_method_id)
      response, status = BeyondAPI::Request.get(@session, "/shipping-zones/#{shipping_zone_id}/shipping-methods/#{shipping_method_id}")

      handle_response(response, status)
    end

    #
    # A +GET+ request is used to list all shipping-methods of a shipping zone in a paged way.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/shipping-zones/8cc24465-3573-4eca-8323-b076bb724080/shipping-methods' -i -X GET \
    #       -H 'Accept: application/hal+json' \
    #       -H 'Authorization: Bearer <Access token>'
    #
    # @beyond_api.scopes +shpz:r+
    #
    # @param shipping_zone_id [String] the shipping zone UUID
    # @option params [Integer] :size the page size
    # @option params [Integer] :page the page number
    #
    # @return [OpenStruct]
    #
    # @example
    #   @shipping_methods = session.shipping_zones.shipping_methods("8cc24465-3573-4eca-8323-b076bb724080", { size: 20, page: 0 })
    #
    def shipping_methods(shipping_zone_id, params = {})
      response, status = BeyondAPI::Request.get(@session, "/shipping-zones/#{shipping_zone_id}/shipping-methods", params)

      handle_response(response, status)
    end

    #
    # A `PUT` request is used to sort the shipping zones. This is done by passing the self-links of the shipping zones in the desired order.all
    # The request must contain URIs for all shipping zones of the given page.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/shipping-zones' -i -X PUT \
    #       -H 'Content-Type: text/uri-list' \
    #       -H 'Authorization: Bearer <Access token>' \
    #       -d 'https://api-shop.beyondshop.cloud/api/shipping-zones/9fa80513-be11-494f-ac01-61832e0d7808
    #   https://api-shop.beyondshop.cloud/api/shipping-zones/f0911d4c-1ab0-4bbd-88e3-cb675cbb7da7
    #   https://api-shop.beyondshop.cloud/api/shipping-zones/ef2e7cb7-820e-4d62-b361-12240f635164'
    #
    # @beyond_api.scopes +shpz:u+
    #
    # @param shipping_zone_ids [Array] the list of shipping zone UUIDs
    #
    # @return [OpenStruct]
    #
    # @example
    #   shipping_zone_ids = ["9fa80513-be11-494f-ac01-61832e0d7808", "f0911d4c-1ab0-4bbd-88e3-cb675cbb7da7", "ef2e7cb7-820e-4d62-b361-12240f635164"]
    #   session.shipping_zones.sort(shipping_zone_ids)
    #
    def sort(shipping_zone_ids)
      body = shipping_zone_ids.map { |shipping_zone_id| "#{session.api_url}/shipping-zones/#{id}" }
      response, status = BeyondAPI::Request.put(@session, "/shipping-zones", body)

      handle_response(response, status, respond_with_true: true)
    end

    #
    # A +PUT+ request is used to sort the shipping methods inside a shipping zone.
    # This is done by passing the self-links of the shipping methods in the desired order. The request must contain URIs for all shipping methods of this shipping zone.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/shipping-zones/e54af33b-fadc-4524-8eec-7e0b3e20f625/shipping-methods' -i -X PUT \
    #       -H 'Accept: application/hal+json' \
    #       -H 'Authorization: Bearer <Access token>'
    #
    # @beyond_api.scopes +shpz:r+
    #
    # @param shipping_zone_id [String] the shipping zone UUID
    #
    # @return [OpenStruct]
    #
    # @example
    #   session.shipping_zones.sort_shipping_methods(shipping_zone_id)
    #
    def sort_shipping_methods(shipping_zone_id)
      response, status = BeyondAPI::Request.put(@session, "/shipping-zones/#{shipping_zone_id}/shipping-methods")

      handle_response(response, status)
    end

    #
    # A +PUT+ request is used to update a shipping zone.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/shipping-zones/727b3cbf-01b1-442a-bd5c-94c51901f090' -i -X PUT \
    #       -H 'Content-Type: application/json' \
    #       -H 'Authorization: Bearer <Access token>' \
    #       -d '{
    #     "name" : "BENELUX region",
    #     "serviceableCountries" : [ "BE", "NL", "LU", "DE" ]
    #   }'
    #
    # @beyond_api.scopes +shpz:u+
    #
    # @param shipping_zone_id [String] the shipping zone UUID
    # @param body [String] the request body
    #
    # @return [OpenStruct]
    #
    # @example
    #   body = {
    #     "name" => "BENELUX region",
    #     "serviceableCountries" => [ "BE", "NL", "LU", "DE" ]
    #   }
    #   @shipping_zone = session.shipping_zones.update("727b3cbf-01b1-442a-bd5c-94c51901f090", body)
    #
    def update(shipping_zone_id, body)
      response, status = BeyondAPI::Request.put(@session, "/shipping-zones/#{shipping_zone_id}", body)

      handle_response(response, status)
    end
  end
end
