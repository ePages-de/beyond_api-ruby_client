# frozen_string_literal: true

require "beyond_api/utils"

module BeyondApi
  class Customers < Base
    include BeyondApi::Utils

    #
    # A +GET+ request is used to list all customers of the shop in a paged way. Each item in the response represents a summary of the customer data.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/customers' -i -X GET \
    #       -H 'Authorization: Bearer <Access token>'
    #
    # @beyond_api.scopes +cust:r+
    #
    # @option params [Boolean] :paginated
    # @option params [Integer] :size the page size
    # @option params [Integer] :page the page number
    #
    # @return [OpenStruct]
    #
    # @example
    #   @customers = session.customers.all(size: 20, page: 0)
    #
    def all(params = {})
      all_results("/customers", :customers, params)
    end

    #
    # A +POST+ request is used to create a customer.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/customers' -i -X POST \
    #       -H 'Content-Type: application/json' \
    #       -H 'Accept: application/hal+json' \
    #       -H 'Authorization: Bearer <Access token>' \
    #       -d '{
    #       "defaultPaymentMethodId" : "69923864-74a7-4ea9-92c7-0d17181b39f4",
    #       "defaultShippingMethodId" : "a5976ec2-d99a-4d16-bd2b-1fa5c48d68aa",
    #       "shippingAddress" : {
    #         "salutation" : "Mrs",
    #         "gender" : "FEMALE",
    #         "company" : "Astrid Alster GmbH",
    #         "title" : "",
    #         "firstName" : "Astrid",
    #         "middleName" : "Agnes",
    #         "lastName" : "Alster",
    #         "street" : "Alsterwasserweg",
    #         "houseNumber" : "2",
    #         "street2" : "Erdgeschoss",
    #         "addressExtension" : "Hinterhof",
    #         "postalCode" : "20999",
    #         "dependentLocality" : "Seevetal",
    #         "city" : "Alsterwasser",
    #         "country" : "DE",
    #         "state" : "Hamburg",
    #         "email" : "a.alsterh@example.com",
    #         "phone" : "(800) 555-0102",
    #         "mobile" : "(800) 555-0103",
    #         "doorCode" : "456",
    #         "_id" : null
    #       },
    #       "email" : "a.alsterh@example.com",
    #       "initialPassword" : "MyVeryStrongPassword",
    #       "billingAddress" : {
    #         "salutation" : "Mrs",
    #         "gender" : "FEMALE",
    #         "company" : "Astrid Alster GmbH",
    #         "title" : "",
    #         "firstName" : "Astrid",
    #         "middleName" : "Agnes",
    #         "lastName" : "Alster",
    #         "street" : "Alsterwasserweg",
    #         "houseNumber" : "2",
    #         "street2" : "Erdgeschoss",
    #         "addressExtension" : "Hinterhof",
    #         "postalCode" : "20999",
    #         "dependentLocality" : "Seevetal",
    #         "city" : "Alsterwasser",
    #         "country" : "DE",
    #         "state" : "Hamburg",
    #         "email" : "a.alsterh@example.com",
    #         "phone" : "(800) 555-0102",
    #         "mobile" : "(800) 555-0103",
    #         "vatId" : "DE123456789",
    #         "taxNumber" : "HRE 987654/32123/864516",
    #         "birthDate" : "1985-05-11",
    #         "_id" : "b61ca0e0-411f-485e-83f3-035d717095da"
    #       }
    #   }'
    #
    # @beyond_api.scopes +cust:c+
    #
    # @param body [Hash] the request body
    #
    # @return [OpenStruct]
    #
    # @example
    #   body = {
    #     "defaultPaymentMethodId" : "69923864-74a7-4ea9-92c7-0d17181b39f4",
    #     "defaultShippingMethodId" : "a5976ec2-d99a-4d16-bd2b-1fa5c48d68aa",
    #     "shippingAddress" : {
    #       "salutation" : "Mrs",
    #       "gender" : "FEMALE",
    #       "company" : "Astrid Alster GmbH",
    #       "title" : "",
    #       "firstName" : "Astrid",
    #       "middleName" : "Agnes",
    #       "lastName" : "Alster",
    #       "street" : "Alsterwasserweg",
    #       "houseNumber" : "2",
    #       "street2" : "Erdgeschoss",
    #       "addressExtension" : "Hinterhof",
    #       "postalCode" : "20999",
    #       "dependentLocality" : "Seevetal",
    #       "city" : "Alsterwasser",
    #       "country" : "DE",
    #       "state" : "Hamburg",
    #       "email" : "a.alsterh@example.com",
    #       "phone" : "(800) 555-0102",
    #       "mobile" : "(800) 555-0103",
    #       "doorCode" : "456",
    #       "_id" : null
    #     },
    #     "email" : "a.alsterh@example.com",
    #     "initialPassword" : "MyVeryStrongPassword",
    #     "billingAddress" : {
    #       "salutation" : "Mrs",
    #       "gender" : "FEMALE",
    #       "company" : "Astrid Alster GmbH",
    #       "title" : "",
    #       "firstName" : "Astrid",
    #       "middleName" : "Agnes",
    #       "lastName" : "Alster",
    #       "street" : "Alsterwasserweg",
    #       "houseNumber" : "2",
    #       "street2" : "Erdgeschoss",
    #       "addressExtension" : "Hinterhof",
    #       "postalCode" : "20999",
    #       "dependentLocality" : "Seevetal",
    #       "city" : "Alsterwasser",
    #       "country" : "DE",
    #       "state" : "Hamburg",
    #       "email" : "a.alsterh@example.com",
    #       "phone" : "(800) 555-0102",
    #       "mobile" : "(800) 555-0103",
    #       "vatId" : "DE123456789",
    #       "taxNumber" : "HRE 987654/32123/864516",
    #       "birthDate" : "1985-05-11",
    #       "_id" : "b61ca0e0-411f-485e-83f3-035d717095da"
    #     }
    #   }
    #
    #   @customer = session.customers.create(body)
    #
    def create(body)
      response, status = BeyondApi::Request.post(@session, "/customers", body)

      handle_response(response, status)
    end

    #
    # A +DELETE+ request is used to delete a customer.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/customers/9e2a61d9-a1ac-4771-bd02-32bf50386392' -i -X DELETE \
    #       -H 'Authorization: Bearer <Access token>'
    #
    # @beyond_api.scopes +cust:d+
    #
    # @param customer_id [String] the customer UUID
    #
    # @return true
    #
    # @example
    #   session.customers.delete("9e2a61d9-a1ac-4771-bd02-32bf50386392")
    #
    def delete(customer_id)
      response, status = BeyondApi::Request.delete(@session, "/customers/#{customer_id}")

      handle_response(response, status, respond_with_true: true)
    end

    #
    # A +GET+ request is used to retrieve the details of a customer.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/customers/d6a8132e-29b3-4258-b8c0-aee34df42aa1' -i -X GET \
    #       -H 'Authorization: Bearer <Access token>'
    #
    # @beyond_api.scopes +cust:r+
    #
    # @param customer_id [String] the customer UUID
    #
    # @return [OpenStruct]
    #
    # @example
    #   @customer = session.customers.find("d6a8132e-29b3-4258-b8c0-aee34df42aa1")
    #
    def find(customer_id)
      response, status = BeyondApi::Request.get(@session, "/customers/#{customer_id}")

      handle_response(response, status)
    end

    #
    # A +PUT+ request is used to update a customer.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/customers/34c5566b-e82a-486d-9a7d-3c3aafef6901' -i -X PUT \
    #       -H 'Content-Type: application/json' \
    #       -H 'Accept: application/hal+json' \
    #       -H 'Authorization: Bearer <Access token>' \
    #       -d '{
    #       "defaultPaymentMethodId" : "d94790cd-ec27-4461-85a9-457fffcc0271",
    #       "defaultShippingMethodId" : "976e7d66-0eb2-4ca3-8b44-5e6d0aeb9e63",
    #       "shippingAddress" : {
    #         "salutation" : "Mrs",
    #         "gender" : "FEMALE",
    #         "company" : "Astrid Alster GmbH",
    #         "title" : "",
    #         "firstName" : "Astrid",
    #         "middleName" : "Agnes",
    #         "lastName" : "Alster",
    #         "street" : "Alsterwasserweg",
    #         "houseNumber" : "2",
    #         "street2" : "Erdgeschoss",
    #         "addressExtension" : "Hinterhof",
    #         "postalCode" : "20999",
    #         "dependentLocality" : "Seevetal",
    #         "city" : "Alsterwasser",
    #         "country" : "DE",
    #         "state" : "Hamburg",
    #         "email" : "a.alsterh@example.com",
    #         "phone" : "(800) 555-0102",
    #         "mobile" : "(800) 555-0103",
    #         "doorCode" : "456",
    #         "_id" : "112d46ff-fc72-4be8-9e48-588b4f5c7829"
    #       },
    #       "billingAddress" : {
    #         "salutation" : "Mrs",
    #         "gender" : "FEMALE",
    #         "company" : "Astrid Alster GmbH",
    #         "title" : "",
    #         "firstName" : "Astrid",
    #         "middleName" : "Agnes",
    #         "lastName" : "Alster",
    #         "street" : "Alsterwasserweg",
    #         "houseNumber" : "2",
    #         "street2" : "Erdgeschoss",
    #         "addressExtension" : "Hinterhof",
    #         "postalCode" : "20999",
    #         "dependentLocality" : "Seevetal",
    #         "city" : "Alsterwasser",
    #         "country" : "DE",
    #         "state" : "Hamburg",
    #         "email" : "a.alsterh@example.com",
    #         "phone" : "(800) 555-0102",
    #         "mobile" : "(800) 555-0103",
    #         "vatId" : "DE123456789",
    #         "taxNumber" : "HRE 987654/32123/864516",
    #         "birthDate" : "1985-05-11",
    #         "_id" : "85de80fc-8467-46ca-b20c-55f5d4d1eaec"
    #       }
    #   }'
    #
    # @beyond_api.scopes +cust:u+
    #
    # @param customer_id [String] the customer UUID
    # @param body [Hash] the request body
    #
    # @return [OpenStruct]
    #
    # @example
    #   body = {
    #     "defaultPaymentMethodId" : "d94790cd-ec27-4461-85a9-457fffcc0271",
    #     "defaultShippingMethodId" : "976e7d66-0eb2-4ca3-8b44-5e6d0aeb9e63",
    #     "shippingAddress" : {
    #       "salutation" : "Mrs",
    #       "gender" : "FEMALE",
    #       "company" : "Astrid Alster GmbH",
    #       "title" : "",
    #       "firstName" : "Astrid",
    #       "middleName" : "Agnes",
    #       "lastName" : "Alster",
    #       "street" : "Alsterwasserweg",
    #       "houseNumber" : "2",
    #       "street2" : "Erdgeschoss",
    #       "addressExtension" : "Hinterhof",
    #       "postalCode" : "20999",
    #       "dependentLocality" : "Seevetal",
    #       "city" : "Alsterwasser",
    #       "country" : "DE",
    #       "state" : "Hamburg",
    #       "email" : "a.alsterh@example.com",
    #       "phone" : "(800) 555-0102",
    #       "mobile" : "(800) 555-0103",
    #       "doorCode" : "456",
    #       "_id" : "112d46ff-fc72-4be8-9e48-588b4f5c7829"
    #     },
    #     "billingAddress" : {
    #       "salutation" : "Mrs",
    #       "gender" : "FEMALE",
    #       "company" : "Astrid Alster GmbH",
    #       "title" : "",
    #       "firstName" : "Astrid",
    #       "middleName" : "Agnes",
    #       "lastName" : "Alster",
    #       "street" : "Alsterwasserweg",
    #       "houseNumber" : "2",
    #       "street2" : "Erdgeschoss",
    #       "addressExtension" : "Hinterhof",
    #       "postalCode" : "20999",
    #       "dependentLocality" : "Seevetal",
    #       "city" : "Alsterwasser",
    #       "country" : "DE",
    #       "state" : "Hamburg",
    #       "email" : "a.alsterh@example.com",
    #       "phone" : "(800) 555-0102",
    #       "mobile" : "(800) 555-0103",
    #       "vatId" : "DE123456789",
    #       "taxNumber" : "HRE 987654/32123/864516",
    #       "birthDate" : "1985-05-11",
    #       "_id" : "85de80fc-8467-46ca-b20c-55f5d4d1eaec"
    #     }
    #   }
    #   @customer = session.customers.update("34c5566b-e82a-486d-9a7d-3c3aafef6901", body)
    #
    def update(customer_id, body)
      response, status = BeyondApi::Request.put(@session, "/customers/#{customer_id}", body)

      handle_response(response, status)
    end
  end
end
