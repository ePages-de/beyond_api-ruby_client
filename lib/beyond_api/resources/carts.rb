# frozen_string_literal: true

require "beyond_api/utils"

module BeyondApi
  class Carts < Base
    include BeyondApi::Utils

    #
    # A +POST+ request is used to add a line item to the cart. Currently only product line items are supported.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/carts/6d529573-b39e-4cd4-99fe-856432ea97f3/line-items' -i -X POST \
    #       -H 'Content-Type: application/json' \
    #       -d '{"_type":"PRODUCT","_ref":"c3a52c19-2b43-4ceb-a7ca-00c558aec072","quantity":1}'
    #
    # @param cart_id [String] the cart UUID
    # @param body [Hash] the request body
    #
    # @return [OpenStruct]
    #
    # @example
    #   body = {
    #     "_type" => "PRODUCT",
    #     "_ref" => "c3a52c19-2b43-4ceb-a7ca-00c558aec072",
    #     "quantity" => 1
    #   }
    #   @cart = session.carts.add_line_item("6d529573-b39e-4cd4-99fe-856432ea97f3", body)
    #
    def add_line_item(cart_id, body)
      response, status = BeyondApi::Request.post(@session,
                                                 "/carts/#{cart_id}/line-items",
                                                 body)

      handle_response(response, status)
    end

    #
    # A +POST+ request is used to create a cart.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/carts' -i -X POST \
    #       -H 'Accept: application/hal+json'
    #
    # @return [OpenStruct]
    #
    # @example
    #   @cart = session.carts.create
    #
    def create
      response, status = BeyondApi::Request.post(@session,
                                                 "/carts")

      handle_response(response, status)
    end

    #
    # A +POST+ request is used to initiate the creation of a payment.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/carts/158bdcee-178a-4b5f-88ff-1953f5ea8e09/create-payment' -i -X POST \
    #       -H 'Content-Type: application/json' \
    #       -H 'Accept: application/hal+json' \
    #       -d '{
    #       "returnUri" : "http://some.com/return",
    #       "cancelUri" : "http://some.com/cancel"
    #   }'
    #
    # @param cart_id [String] the cart UUID
    # @param body [Hash] the request body
    #
    # @return [OpenStruct]
    #
    # @example
    #   body = {
    #     "returnUri" => "http://some.com/return",
    #     "cancelUri" => "http://some.com/cancel"
    #   }
    #   @payment = session.carts.create_payment("158bdcee-178a-4b5f-88ff-1953f5ea8e09/", body)
    #
    def create_payment(cart_id, body)
      response, status = BeyondApi::Request.post(@session,
                                                 "/carts/#{cart_id}/create-payment",
                                                 body)

      handle_response(response, status)
    end

    #
    # A +POST+ request is used to create an order from a cart and initiate the payment.
    #
    # $ curl 'https://api-shop.beyondshop.cloud/api/carts/f6c6615b-a9f6-420e-be1d-46339ddc5fda/create-payment-and-order' -i -X POST \
    #     -H 'Content-Type: application/json' \
    #     -H 'Accept: application/hal+json' \
    #     -d '{
    #     "returnUri" : "http://some.com/return",
    #     "cancelUri" : "http://some.com/cancel",
    #     "customerComment" : "Send it fast please!",
    #     "salesChannel" : "Storefront",
    #     "marketingChannel" : "Google",
    #     "marketingSubchannel" : "Search page 2",
    #     "testOrder" : false,
    #     "termsAndConditionsExplicitlyAccepted" : false
    #   }'
    #
    # @param cart_id [String] the cart UUID
    # @param body [Hash] the request body
    #
    # @return [OpenStruct]
    #
    # @example
    #   body = {
    #     "returnUri" => "http://some.com/return",
    #     "cancelUri" => "http://some.com/cancel",
    #     "customerComment" => "Send it fast please!",
    #     "salesChannel" => "Storefront",
    #     "marketingChannel" => "Google",
    #     "marketingSubchannel" => "Search page 2",
    #     "testOrder" => false,
    #     "termsAndConditionsExplicitlyAccepted" => false
    #   }
    #   @payment = session.carts.create_payment_and_order("f6c6615b-a9f6-420e-be1d-46339ddc5fda", body)
    #
    def create_payment_and_order(cart_id, body)
      response, status = BeyondApi::Request.post(@session,
                                                 "/carts/#{cart_id}/create-payment-and-order",
                                                 body)

      handle_response(response, status)
    end

    #
    # A +POST+ request is used to create an order from the cart.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/carts/986247da-b78f-422c-a273-917804896974/order' -i -X POST \
    #       -H 'Content-Type: application/json' \
    #       -d '{"customerComment": "send it fast please",
    #       "salesChannel": "DifferentChannel",
    #       "marketingChannel": "Google",
    #       "marketingSubchannel": "Search page 2",
    #       "testOrder": false,
    #       "termsAndConditionsExplicitlyAccepted": true
    #   }'
    #
    # @param cart_id [String] the cart UUID
    # @param body [Hash] the request body
    #
    # @return [OpenStruct]
    #
    # @example
    #   body = {
    #     "customerComment" => "send it fast please",
    #     "salesChannel" => "DifferentChannel",
    #     "marketingChannel" => "Google",
    #     "marketingSubchannel" => "Search page 2",
    #     "testOrder" => false,
    #     "termsAndConditionsExplicitlyAccepted" => true
    #   }
    #   @order = session.carts.create_order("986247da-b78f-422c-a273-917804896974", body)
    #
    def create_order(cart_id, body)
      response, status = BeyondApi::Request.post(@session,
                                                 "/carts/#{cart_id}/order",
                                                 body)

      handle_response(response, status)
    end

    #
    # A +DELETE+ request is used to delete a cart.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/carts/1a58f22f-481a-4993-9947-62c1c2857f87' -i -X DELETE
    #
    # @param cart_id [String] the cart UUID
    #
    # @return true
    #
    # @example
    #   session.carts.delete("1a58f22f-481a-4993-9947-62c1c2857f87")
    #
    def delete(cart_id)
      response, status = BeyondApi::Request.delete(@session,
                                                   "/carts/#{cart_id}")

      handle_response(response, status, respond_with_true: true)
    end

    #
    # A +DELETE+ request is used to delete a line item from the cart.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/carts/3fb55475-f6d2-471a-90ac-ccee7896b9f7/line-items/51c86195-d2b9-4073-9a14-7ddd5a76b6a7' -i -X DELETE
    #
    # @param cart_id [String] the cart UUID
    # @param line_item_id [String] the line item UUID
    #
    # @return true
    #
    # @example
    #   @cart = session.carts.delete_line_item("3fb55475-f6d2-471a-90ac-ccee7896b9f7", "51c86195-d2b9-4073-9a14-7ddd5a76b6a7")
    #
    def delete_line_item(cart_id, line_item_id)
      response, status = BeyondApi::Request.delete(@session,
                                                   "/carts/#{cart_id}/line-items/#{line_item_id}")

      handle_response(response, status, respond_with_true: true)
    end

    #
    # A +DELETE+ request is used to remove the shipping address of the cart. After deletion, the shipping address will default to the billing address.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/carts/2fa7dc36-8305-4628-b961-f2c3f7dda47d/shipping-address' -i -X DELETE \
    #       -H 'Accept: application/hal+json'
    #
    # @param cart_id [String] the cart UUID
    #
    # @return true
    #
    # @example
    #   session.carts.delete_shipping_address("2fa7dc36-8305-4628-b961-f2c3f7dda47d")
    #
    def delete_shipping_address(cart_id)
      response, status = BeyondApi::Request.delete(@session,
                                                   "/carts/#{cart_id}/shipping-address")

      handle_response(response, status, respond_with_true: true)
    end

    #
    # A +GET+ request is used to retrieve the details of a cart.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/carts/26857145-aeab-4210-9191-3906573a14ae' -i -X GET \
    #       -H 'Content-Type: application/json' \
    #       -H 'Accept: application/hal+json'
    #
    # @param cart_id [String] the cart UUID
    #
    # @return [OpenStruct]
    #
    # @example
    #   @cart = session.carts.find("26857145-aeab-4210-9191-3906573a14ae")
    #
    def find(cart_id)
      response, status = BeyondApi::Request.get(@session,
                                                "/carts/#{cart_id}")

      handle_response(response, status)
    end

    #
    # A +GET+ request is used to retrieve the current payment method.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/carts/6d9de289-d6a7-44d6-afb3-c31bb0a792ff/payment-methods/current' -i -X GET \
    #       -H 'Content-Type: application/json' \
    #       -H 'Accept: application/hal+json'
    # @param cart_id [String] the cart UUID
    #
    # @return [OpenStruct]
    #
    # @example
    #   @payment_method = session.carts.payment_method("26857145-aeab-4210-9191-3906573a14ae")
    #
    def payment_method(cart_id)
      response, status = BeyondApi::Request.get(@session,
                                                "/carts/#{cart_id}/payment-methods/current")

      handle_response(response, status)
    end

    #
    # A +GET+ request is used to get the applicable payment methods of a cart.
    # The selectable field indicates if a payment method is currently selectable. Non-selectable payment methods are currently restricted because of rules that apply to a cart.
    # Trying to set such a payment method as the current one of the cart will fail.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/carts/45f9009d-4d2f-43b1-9cd2-ea29ff0d46d6/payment-methods' -i -X GET \
    #       -H 'Content-Type: application/json' \
    #       -H 'Accept: application/hal+json'
    #
    # @param cart_id [String] the cart UUID
    #
    # @return [OpenStruct]
    #
    # @example
    #   @payment_methods = session.carts.payment_methods("45f9009d-4d2f-43b1-9cd2-ea29ff0d46d6")
    #
    def payment_methods(cart_id)
      response, status = BeyondApi::Request.get(@session,
                                                "/carts/#{cart_id}/payment-methods")

      handle_response(response, status)
    end

    #
    # A +PUT+ request is used to replace only one line item in the cart.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/carts/f73629e5-fecf-4474-9b04-6b2fcd4663c4/line-items/2c9c0f38-0b9e-4fa7-bcbe-960098ff63aa' -i -X PUT \
    #       -H 'Content-Type: application/json' \
    #       -d '{"_type":"PRODUCT","_ref":"f084553c-ea77-4745-b1bd-71c64c8419fd","quantity":2}'
    #
    # @param cart_id [String] the cart UUID
    # @param line_item_id [String] the line item UUID
    # @param body [Hash] the request body
    #
    # @return [OpenStruct]
    #
    # @example
    #   body = {
    #     "_type" => "PRODUCT",
    #     "_ref" => "f084553c-ea77-4745-b1bd-71c64c8419fd",
    #     "quantity" => 2
    #   }
    #
    #   @cart = session.carts.replace_line_item("f73629e5-fecf-4474-9b04-6b2fcd4663c4", "2c9c0f38-0b9e-4fa7-bcbe-960098ff63aa", body)
    #
    def replace_line_item(cart_id, line_item_id, body)
      response, status = BeyondApi::Request.put(@session,
                                                "/carts/#{cart_id}/line-items/#{line_item_id}",
                                                body)

      handle_response(response, status)
    end

    #
    # A +PUT+ request is used to replace the current line items in the cart with the given list.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/carts/c1436110-e283-49b3-a748-0321efec6d35/line-items' -i -X PUT \
    #       -H 'Content-Type: application/json' \
    #       -d '[{"_type":"PRODUCT","_ref":"0612362d-9856-4b40-94c6-a36abec0cf8c","quantity":1}]'
    #
    # @param cart_id [String] the cart UUID
    # @param body [String] the array of line items
    #
    # @return [OpenStruct]
    #
    # @example
    #   body = [ {
    #     "_type" => "PRODUCT",
    #     "_ref" => "0612362d-9856-4b40-94c6-a36abec0cf8c",
    #     "quantity" => 1
    #   } ]
    #
    #   @cart = session.carts.replace_line_items("c1436110-e283-49b3-a748-0321efec6d35", body)
    #
    def replace_line_items(cart_id, body)
      response, status = BeyondApi::Request.put(@session,
                                                "/carts/#{cart_id}/line-items",
                                                body)

      handle_response(response, status)
    end

    #
    # A +PUT+ request is used to set the billing address of the cart. The billing address is mandatory for a cart being ready to order.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/carts/01da6aa7-8aa2-4383-a496-6611a14afbc9/billing-address' -i -X PUT \
    #       -H 'Content-Type: application/json' \
    #       -H 'Accept: application/hal+json' \
    #       -d '{"salutation":"Mrs","gender":"FEMALE","title":"","firstName":"Astrid","middleName":"Agnes","lastName":"Alster","street":"Alsterwasserweg",
    #            "houseNumber":"2","street2":"Erdgeschoss","doorCode":"0185","addressExtension":"Hinterhof","postalCode":"20999","dependentLocality":"Seevetal",
    #            "city":"Alsterwasser","country":"DE","state":"Hamburg","email":"a.alsterh@example.com","phone":"(800) 555-0102","mobile":"(800) 555-0103",
    #            "vatId":"123456789","taxNumber":"123-34-6789","birthDate":"1985-03-20"}'
    #
    # @param cart_id [String] the cart UUID
    # @param body [Hash] the request body
    #
    # @return [OpenStruct]
    #
    # @example
    #   body = {
    #     "salutation" => "Mrs",
    #     "gender" => "FEMALE",
    #     "title" => "",
    #     "firstName" => "Astrid",
    #     "middleName" => "Agnes",
    #     "lastName" => "Alster",
    #     "street" => "Alsterwasserweg",
    #     "houseNumber" => "2",
    #     "street2" => "Erdgeschoss",
    #     "doorCode" => "0185",
    #     "addressExtension" => "Hinterhof",
    #     "postalCode" => "20999",
    #     "dependentLocality" => "Seevetal",
    #     "city" => "Alsterwasser",
    #     "country" => "DE",
    #     "state" => "Hamburg",
    #     "email" => "a.alsterh@example.com",
    #     "phone" => "(800) 555-0102",
    #     "mobile" => "(800) 555-0103",
    #     "vatId" => "123456789",
    #     "taxNumber" => "123-34-6789",
    #     "birthDate" => "1985-03-20"
    #   }
    #
    #   @cart = session.carts.set_billing_address("01da6aa7-8aa2-4383-a496-6611a14afbc9", body)
    #
    def set_billing_address(cart_id, body)
      response, status = BeyondApi::Request.put(@session,
                                                "/carts/#{cart_id}/billing-address",
                                                body)

      handle_response(response, status)
    end

    #
    # A +PUT+ request is used to set the current payment method of the cart.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/carts/750c8a68-ef58-4955-b05f-29e35fa19687/payment-methods/current' -i -X PUT \
    #       -H 'Content-Type: text/uri-list' \
    #       -H 'Accept: application/json' \
    #       -d 'https://api-shop.beyondshop.cloud/api/payment-methods/6498f339-7fe6-43d4-8e2a-6da68d7cdfe3'
    #
    # @param cart_id [String] the cart UUID
    # @param payment_method_id [String] the payment method UUID
    #
    # @return [OpenStruct]
    #
    # @example
    #   @cart = session.carts.set_payment_method("750c8a68-ef58-4955-b05f-29e35fa19687", "6498f339-7fe6-43d4-8e2a-6da68d7cdfe3")
    #
    def set_payment_method(cart_id, payment_method_id)
      response, status = BeyondApi::Request.put(@session,
                                                "/carts/#{cart_id}/payment-methods/current",
                                                "#{@session.api_url}/payment-methods/#{payment_method_id}")

      handle_response(response, status)
    end

    #
    # A +PUT+ request is used to set the payment method to the current default payment method. The default payment method is the one with the highest priority of the applicable payment methods.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/carts/d1efcb74-ab96-43c5-b404-9c1f927dc3d2/payment-methods/default' -i -X PUT \
    #       -H 'Content-Type: application/json' \
    #       -H 'Accept: application/json'
    #
    # @param cart_id [String] the cart UUID
    #
    # @return [OpenStruct]
    #
    # @example
    #   @cart = session.carts.set_payment_method_to_default("d1efcb74-ab96-43c5-b404-9c1f927dc3d2")
    #
    def set_payment_method_to_default(cart_id)
      response, status = BeyondApi::Request.put(@session,
                                                "/carts/#{cart_id}/payment-methods/default")

      handle_response(response, status)
    end

    #
    # A +PUT+ request is used to set the shipping address of the cart. If a shipping address is not set, it will default to the billing address.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/carts/01da6aa7-8aa2-4383-a496-6611a14afbc9/shipping-address' -i -X PUT \
    #       -H 'Content-Type: application/json' \
    #       -H 'Accept: application/hal+json' \
    #       -d '{"salutation":"Mrs","gender":"FEMALE","title":"","firstName":"Astrid","middleName":"Agnes","lastName":"Alster","street":"Alsterwasserweg",
    #            "houseNumber":"2","street2":"Erdgeschoss","doorCode":"0185","addressExtension":"Hinterhof","postalCode":"20999","dependentLocality":"Seevetal",
    #            "city":"Alsterwasser","country":"DE","state":"Hamburg","email":"a.alsterh@example.com","phone":"(800) 555-0102","mobile":"(800) 555-0103",
    #            "vatId":"123456789","taxNumber":"123-34-6789","birthDate":"1985-03-20"}'
    #
    # @param cart_id [String] the cart UUID
    # @param body [Hash] the request body
    #
    # @return [OpenStruct]
    #
    # @example
    #   body = {
    #     "salutation" => "Mrs",
    #     "gender" => "FEMALE",
    #     "title" => "",
    #     "firstName" => "Astrid",
    #     "middleName" => "Agnes",
    #     "lastName" => "Alster",
    #     "street" => "Alsterwasserweg",
    #     "houseNumber" => "2",
    #     "street2" => "Erdgeschoss",
    #     "doorCode" => "0185",
    #     "addressExtension" => "Hinterhof",
    #     "postalCode" => "20999",
    #     "dependentLocality" => "Seevetal",
    #     "city" => "Alsterwasser",
    #     "country" => "DE",
    #     "state" => "Hamburg",
    #     "email" => "a.alsterh@example.com",
    #     "phone" => "(800) 555-0102",
    #     "mobile" => "(800) 555-0103",
    #     "vatId" => "123456789",
    #     "taxNumber" => "123-34-6789",
    #     "birthDate" => "1985-03-20"
    #   }
    #
    #   @cart = session.carts.set_shipping_address("01da6aa7-8aa2-4383-a496-6611a14afbc9", body)
    #
    def set_shipping_address(cart_id, body)
      response, status = BeyondApi::Request.put(@session,
                                                "/carts/#{cart_id}/shipping-address",
                                                body)

      handle_response(response, status)
    end

    #
    # A +PUT+ request is used to set the current shipping method of the cart.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/carts/a4e7922a-f895-4a7d-8cb1-6ecf74d7ceba/shipping-methods/current' -i -X PUT \
    #       -H 'Content-Type: text/uri-list' \
    #       -H 'Accept: application/json' \
    #       -d 'https://api-shop.beyondshop.cloud/api/shipping-zones/59e26c99-ef1d-4ee8-a79f-d078cd6dfe24/shipping-methods/f3d3ce8d-eeab-44b6-81bb-67a4f1d7a57f'
    #
    # @param cart_id [String] the cart UUID
    # @param shipping_zone_id [String] the shipping zone UUID
    # @param shipping_method_id [String] the shipping method UUID
    #
    # @return [OpenStruct]
    #
    # @example
    #   @cart = session.carts.set_shipping_method("a4e7922a-f895-4a7d-8cb1-6ecf74d7ceba", "59e26c99-ef1d-4ee8-a79f-d078cd6dfe24", "f3d3ce8d-eeab-44b6-81bb-67a4f1d7a57f")
    #
    def set_shipping_method(cart_id, shipping_zone_id, shipping_method_id)
      response, status = BeyondApi::Request.put(@session,
                                                "/carts/#{cart_id}/shipping-methods/current",
                                                "#{session.api_url}/shipping-zones/#{shipping_zone_id}/shipping-methods/#{shipping_method_id}")

      handle_response(response, status)
    end

    #
    # A +PUT+ request is used to set the shipping method to the current default shipping method.
    # The default shipping method is the one with the highest priority of the applicable shipping methods.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/carts/c31c5d06-4460-4f89-9e09-47f9956dea98/shipping-methods/default' -i -X PUT \
    #       -H 'Content-Type: application/json' \
    #       -H 'Accept: application/json'
    #
    # @param cart_id [String] the cart UUID
    #
    # @return [OpenStruct]
    #
    # @example
    #   @cart = session.carts.set_shipping_method_to_default("c31c5d06-4460-4f89-9e09-47f9956dea98")
    #
    def set_shipping_method_to_default(cart_id)
      response, status = BeyondApi::Request.put(@session,
                                                "/carts/#{cart_id}/shipping-methods/default")

      handle_response(response, status)
    end

    #
    # A +GET+ request is used to get the current shipping method.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/carts/9093a339-66fd-4cc1-9dcf-d23003c38b41/shipping-methods/current' -i -X GET \
    #       -H 'Content-Type: application/json' \
    #       -H 'Accept: application/hal+json'
    #
    # @param cart_id [String] the cart UUID
    #
    # @return [OpenStruct]
    #
    # @example
    #   @shipping_method = session.carts.shipping_method("9093a339-66fd-4cc1-9dcf-d23003c38b41")
    #
    def shipping_method(cart_id)
      response, status = BeyondApi::Request.get(@session,
                                                "/carts/#{cart_id}")

      handle_response(response, status)
    end

    # A +GET+ request is used to get the applicable shipping method of a cart.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/carts/05a547a0-80dc-4a8c-b9b6-aa028b6ef7d8/shipping-methods' -i -X GET \
    #       -H 'Content-Type: application/json' \
    #       -H 'Accept: application/hal+json'
    #
    # @param cart_id [String] the cart UUID
    #
    # @return [OpenStruct]
    #
    # @example
    #   @cart = session.carts.shipping_methods("05a547a0-80dc-4a8c-b9b6-aa028b6ef7d8")
    #
    def shipping_methods(cart_id)
      response, status = BeyondApi::Request.get(@session,
                                                "/carts/#{cart_id}")

      handle_response(response, status)
    end
  end
end
