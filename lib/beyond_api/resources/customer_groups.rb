# frozen_string_literal: true

require "beyond_api/utils"

module BeyondApi
  class CustomerGroups < Base
    include BeyondApi::Utils
    #
    # A +GET+ request is used to list all customer groups of a shop in a paged way. Each item in the response represents a summary of the customer group data.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/customer-groups' -i -X POST \
    #       -H 'Authorization: Bearer <Access token>'
    #
    # @beyond_api.scopes +cugr:r+
    #
    # @return [OpenStruct]
    #
    # @example
    #   @customer_groups = session.customer_groups.all
    #
    def all(params = {})
      response, status = BeyondApi::Request.get(@session, "/customer-groups", params)

      handle_response(response, status)
    end

    #
    # A +POST+ request is used to add a customer to a provided list of groups.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/customers/fb5f14ac-f274-4673-ad40-6712dfeea1ba/customer-groups' -i -X POST \
    #       -H 'Content-Type: application/json' \
    #       -H 'Authorization: Bearer <Access token>'
    #       -d '["5d94fa06-f58c-4379-9714-5dc57877c186"]'
    #
    # @beyond_api.scopes +cugr:r+
    #
    # @return [OpenStruct]
    #
    # @example
    #   @customer_groups = session.add_customer("fb5f14ac-f274-4673-ad40-6712dfeea1ba", ["5d94fa06-f58c-4379-9714-5dc57877c186"])
    #
    def add_customer(customer_id, customer_group_ids)
      response, status = BeyondApi::Request.post(@session,
                                                 "/customers/#{customer_id}/customer-groups",
                                                 customer_group_ids)

      handle_response(response, status)
    end
  end
end
