# frozen_string_literal: true

module BeyondApi
  module Checkout
    # @example How to instantiate a client
    #   @client = BeyondApi::Checkout::Cart.new(api_url: 'https://example.com/api', access_token: 'your_token')
    class Cart < BaseService
      # Create a cart.
      #
      # @see https://developer.epages.com/beyond-docs/#create_cart
      #
      # @return [Hash]
      #
      # @example
      #   @client.create
      def create
        post('carts')
      end

      # Retrieve the details of a cart.
      #
      # @see https://developer.epages.com/beyond-docs/#show_cart_details
      #
      # @param id [String] the cart UUID
      #
      # @return [Hash]
      #
      # @example
      #   @client.find('1b9ab4a0-c1c4-4373-b35d-ee36e004e860')
      def find(id)
        get("carts/#{id}")
      end

      # Remove a cart.
      #
      # @see https://developer.epages.com/beyond-docs/#delete_cart
      #
      # @param id [String] the cart UUID
      #
      # @return [Hash] an empty hash
      #
      # @example
      #   @client.delete('c4368b98-d291-45b9-815c-eb5e835ea07d')
      def delete(id)
        super("carts/#{id}")
      end

      # Create order from cart.
      #
      # @see https://developer.epages.com/beyond-docs/#create_order_from_cart
      #
      # @param id [String] the cart UUID
      # @param body [Hash] the order data
      #
      # @return [Hash]
      #
      # @example
      #   body = {
      #     customer_comment: 'Please send with UPS.',
      #     sales_channel: 'Storefront',
      #     marketing_channel: 'Google Shopping',
      #     marketing_subchannel: 'Summer Sale',
      #     test_order: false,
      #     terms_and_conditions_explicitly_accepted: true
      #   }
      #   @client.create_order_from('bbfe107a-4583-44b0-afc8-f09e7c679996')
      def create_order_from(id, body)
        post("carts/#{id}/order", body)
      end

      # Add a line item to the cart. Currently only product line items are supported.
      #
      # @see https://developer.epages.com/beyond-docs/#add_single_line_item_to_cart
      #
      # @param id [String] the cart UUID
      # @param body [Hash] the order data
      # @param body [Hash] the line item data
      #
      # @return [Hash]
      #
      # @example
      #   body = {
      #     _type: "PRODUCT",
      #     _ref: "068a0635-7a4a-435b-82d4-479112319b22",
      #     quantity: 1,
      #     custom_text: "John Doe"
      #   }
      #   @client.add_line_item('98db82a0-d5b8-458d-95d1-6f6cd7467320', body)
      def add_line_item(id, body)
        post("carts/#{id}/line-items", body)
      end

      # Replace only one item in the cart.
      #
      # @see https://developer.epages.com/beyond-docs/#replace_single_line_item
      #
      # @param cart_id [String] the cart UUID
      # @param line_item_id [String] the line item UUID
      # @param body [Hash] the line item data
      #
      # @return [Hash]
      #
      # @example
      #   body = {
      #     _type: "PRODUCT",
      #     _ref: "61aeebfb-68c7-4bab-a460-64234f48c99b",
      #     quantity: 2
      #   }
      #   @client.replace_line_item('a64545e4-b06e-4067-aa6a-5aa1124990fa',
      #                             '86c72e9b-1db2-4ce0-966f-67ecbca71a7d', body)
      def replace_line_item(cart_id, line_item_id, body)
        put("carts/#{cart_id}/line-items/#{line_item_id}", body)
      end

      # Delete a line item from the cart.
      #
      # @see https://developer.epages.com/beyond-docs/#delete_line_item
      #
      # @param cart_id [String] the cart UUID
      # @param line_item_id [String] the line item UUID
      #
      # @return [Hash]
      #
      # @example
      #   @client.delete_line_item('7c109d12-6598-4150-810c-24006e8e6780',
      #                            'fb459c80-b745-46f6-83ae-f533236c9f26')
      def delete_line_item(cart_id, line_item_id)
        super("carts/#{cart_id}/line-items/#{line_item_id}")
      end

      # Set the billing address of the cart. The billing address is mandatory for a cart being ready to order.
      #
      # @see https://developer.epages.com/beyond-docs/#set_cart_billing_address
      #
      # @param cart_id [String] the cart UUID
      # @param body [Hash] the billing address data
      #
      # @return [Hash]
      #
      # @example
      #   body = {
      #     customer_data = {
      #     salutation: 'Mrs',
      #     gender: 'FEMALE',
      #     title: 'Dr',
      #     first_name: 'Astrid',
      #     middle_name: 'Agnes',
      #     last_name: 'Alster',
      #     street: 'Alsterwasserweg',
      #     house_number: '2',
      #     street2: 'Erdgeschoss',
      #     door_code: '0185',
      #     address_extension: 'Hinterhof',
      #     postal_code: '20999',
      #     dependent_locality: 'Seevetal',
      #     city: 'Alsterwasser',
      #     country: 'DE',
      #     state: 'Hamburg',
      #     email: 'a.alsterh@example.com',
      #     phone: '(800) 555-0102',
      #     mobile: '(800) 555-0103',
      #     vat_id: '123456789',
      #     tax_number: '123-34-6789',
      #     birth_date: '1985-03-20'
      #   }
      #   @client.billing_address('f1209f49-e225-4840-8897-2cf0d59268ef', body)
      def billing_address(cart_id, body)
        put("carts/#{cart_id}/billing-address", body)
      end

      # Set the shipping address of the cart.  If no shipping address is set and no pickup line item is available, it will default to the billing address.
      #
      # @see https://developer.epages.com/beyond-docs/#set_cart_shipping_address
      #
      # @param cart_id [String] the cart UUID
      # @param body [Hash] the shipping address data
      #
      # @return [Hash]
      #
      # @example
      #   body = {
      #     customer_data = {
      #     salutation: 'Mrs',
      #     gender: 'FEMALE',
      #     title: 'Dr',
      #     first_name: 'Astrid',
      #     middle_name: 'Agnes',
      #     last_name: 'Alster',
      #     street: 'Alsterwasserweg',
      #     house_number: '2',
      #     street2: 'Erdgeschoss',
      #     door_code: '0185',
      #     address_extension: 'Hinterhof',
      #     postal_code: '20999',
      #     dependent_locality: 'Seevetal',
      #     city: 'Alsterwasser',
      #     country: 'DE',
      #     state: 'Hamburg',
      #     email: 'a.alsterh@example.com',
      #     phone: '(800) 555-0102',
      #     mobile: '(800) 555-0103',
      #     vat_id: '123456789',
      #     tax_number: '123-34-6789',
      #     birth_date: '1985-03-20'
      #   }
      #   @client.shipping_address('f1209f49-e225-4840-8897-2cf0d59268ef', body)
      def shipping_address(cart_id, body)
        put("carts/#{cart_id}/shipping-address", body)
      end

      # Remove the shipping address of the cart. After deletion, the shipping address will default to the billing address.
      #
      # @see https://developer.epages.com/beyond-docs/#remove_cart_shipping_address
      #
      # @param id [String] the cart UUID
      #
      # @return [Hash] an empty hash
      #
      # @example
      #   @client.delete_shipping_address('4aef7525-0742-4a0d-9285-dee00693fd1a')
      def delete_shipping_address(id)
        super("carts/#{id}/shipping-address")
      end

      # List all applicable payment methods for the current cart.
      #
      # @see https://developer.epages.com/beyond-docs/#list_applicable_payment_methods_for_current_cart
      #
      # @param id [String] the cart UUID
      #
      # @return [Hash]
      #
      # @example
      #   @client.payment_methods('e4ab6de8-9877-4552-9c6b-0544ee769f6f')
      def payment_methods(id)
        get("carts/#{id}/payment-methods")
      end

      # Set the current payment method of a cart.
      #
      # @see https://developer.epages.com/beyond-docs/#set_current_cart_payment_method
      #
      # @param cart_id [String] the cart UUID
      # @param payment_method_id [Array] the payment method id
      #
      # @return [Hash]
      #
      # @example
      #   @client.assign_current_payment_method('f5945d59-9d0e-4ecc-818a-6cdbfd772ae2',
      #                                         '5f9c32c4-8598-4510-a468-33d156a3570f')
      def assign_current_payment_method(cart_id, payment_method_id)
        body = "#{@session.api_url}/payment-methods/#{payment_method_id}"
        put("carts/#{cart_id}/payment-methods/current", body)
      end

      # Set the cart payment method to the current default payment method.
      #
      # @see https://developer.epages.com/beyond-docs/#set_cart_payment_method_to_current_default
      #
      # @param cart_id [String] the cart UUID
      #
      # @return [Hash]
      #
      # @example
      #   @client.assign_payment_method_to_default('ce1f18a0-bae9-4807-bf12-964d2ad02c1c')
      def assign_payment_method_to_default(cart_id)
        put("carts/#{cart_id}/payment-methods/default")
      end

      # Retrieve the details of the current payment method of a cart.
      #
      # @see https://developer.epages.com/beyond-docs/#show_current_cart_payment_method_details
      #
      # @param id [String] the cart UUID
      #
      # @return [Hash]
      #
      # @example
      #   @client.payment_method('be513bae-f515-4ec4-a430-ee070f398f56')
      def payment_method(id)
        get("carts/#{id}/payment-methods/current")
      end

      # Initiate the creation of a payment.
      #
      # @see https://developer.epages.com/beyond-docs/#create_payment
      #
      # @param id [String] the cart UUID
      # @param body [Hash] the payment data
      #
      # @return [Hash]
      #
      # @example
      #   body = {
      #     return_uri: 'https://example.com/return',
      #     cancel_uri: 'https://example.com/cancel',
      #   }
      #   @client.create_payment('0fd2455e-f9a0-4180-b26a-032837c13ab1', body)
      def create_payment(id, body)
        post("carts/#{id}/create-payment", body)
      end

      # Initiate the creation of a payment and order for the cart.
      #
      # @see https://developer.epages.com/beyond-docs/#create_payment_and_order
      #
      # @param id [String] the cart UUID
      # @param body [Hash] the request body
      #
      # @return [Hash]
      #
      # @example
      #   body = {
      #     return_uri: 'https://example.com/return',
      #     cancel_uri: 'https://example.com/cancel',
      #     customer_comment: 'Please send with UPS.',
      #     sales_channel: 'Storefront',
      #     marketing_channel: 'Google Shopping',
      #     marketing_subchannel: 'Summer Sale',
      #     test_order: false,
      #     terms_and_conditions_explicitly_accepted: true
      #   }
      #   @client.create_payment('0fd2455e-f9a0-4180-b26a-032837c13ab1', body)
      def create_payment_and_order(id, body)
        post("carts/#{id}/create-payment", body)
      end

      # Set the current shipping method of the cart.
      #
      # @see https://developer.epages.com/beyond-docs/#set_current_cart_shipping_method
      #
      # @param cart_id [String] the cart UUID
      # @param shipping_zone_id [String] the shipping zone UUID
      # @param shipping_method_id [String] the shipping method UUID
      #
      # @return [Hash]
      #
      # @example
      #   @client.assign_current_shipping_method('d806c45a-c799-493a-8d91-57c51e6adc2c'
      #                                          'bd5be855-24d9-4f38-9469-4089c0083c87',
      #                                          'a12e4246-0b72-4ac4-943d-79ab792965dd')
      def assign_current_shipping_method(cart_id, shipping_zone_id, shipping_method_id)
        body = "#{@session.api_url}/shipping-zones/#{shipping_zone_id}/shipping-methods/#{shipping_method_id}"
        put("carts/#{cart_id}/shipping-methods", body)
      end

      # Set the cart shipping method to the current default shipping method.
      #
      # @see https://developer.epages.com/beyond-docs/#set_cart_shipping_method_to_current_default
      #
      # @param cart_id [String] the cart UUID
      #
      # @return [Hash]
      #
      # @example
      #   @client.assign_shipping_method_to_default('0295ce92-9604-46b7-a995-608f9c966753')
      def assign_shipping_method_to_default(cart_id)
        put("carts/#{cart_id}/payment-methods/default")
      end

      # Retrieve the details of the current shipping method of a cart.
      #
      # @see https://developer.epages.com/beyond-docs/#show_current_cart_shipping_method_details
      #
      # @param id [String] the cart UUID
      #
      # @return [Hash]
      #
      # @example
      #   @client.shipping_method('fd54acab-bc23-4d81-bef2-77c8f3150a3b')
      def shipping_method(id)
        get("carts/#{id}/shipping-methods/current")
      end

      # List all countries that are assigned to at least one shipping zone of the shop. Orders can only be shipped to such servicable countries.
      #
      # @see https://developer.epages.com/beyond-docs/#find_serviceable_countries
      #
      # @return [Hash]
      #
      # @example
      #   @client.serviceable_countries
      def serviceable_countries
        get('shipping-zones/search/find-all-serviceable-countries')
      end

      # List all applicable pickup options for the current cart.
      #
      # @see https://developer.epages.com/beyond-docs/#list_applicable_pickup_options_for_current_cart
      #
      # @param id [String] the cart UUID
      #
      # @return [Hash]
      #
      # @example
      #   @client.pickup_options('00954827-a00a-444e-beba-26ea3ffaf4db')
      def pickup_options(id)
        get("carts/#{id}/pickup-options")
      end

      # Set the current pickup option of the cart.
      #
      # @see https://developer.epages.com/beyond-docs/#set_current_cart_pickup_option
      #
      # @param cart_id [String] the cart UUID
      # @param pickup_option_id [String] the pickup option UUID
      #
      # @return [Hash]
      #
      # @example
      #   @client.assign_current_pickup_option('6d16f50b-a0f9-4797-b524-77ade8d2c14b',
      #                                        '7bb761bf-5bab-4baa-8e9d-0c86491e0850')
      def assign_current_pickup_option(cart_id, pickup_option_id)
        body = "#{@session.api_url}/pickup-options/#{pickup_option_id}"
        put("carts/#{cart_id}/pickup-options/current", body)
      end

      # Retrieve the details of the current pickup option of a cart.
      #
      # @see https://developer.epages.com/beyond-docs/#show_current_cart_pickup_option_details
      #
      # @param id [String] the cart UUID
      #
      # @return [Hash]
      #
      # @example
      #   @client.current_pickup_option('53e4e9d3-54d2-4eb8-ba6c-346d665d71ae')
      def pickup_option(id)
        get("carts/#{id}/pickup-options/current")
      end

      # Remove the current pickup option from the cart.
      #
      # @see https://developer.epages.com/beyond-docs/#remove_current_cart_pickup_option
      #
      # @param id [String] the cart UUID
      #
      # @return [Hash] an empty hash
      #
      # @example
      #   @client.delete('c6d3a1e8-db98-412a-a4ca-0489d0e210f5')
      def delete_current_pickup_option(id)
        super("carts/#{id}/pickup-options/current")
      end

      # Redeem a coupon.
      #
      # @see https://developer.epages.com/beyond-docs/#redeem_coupon
      #
      # @param id [String] the cart UUID
      # @param coupon_code [String] the coupon codee
      #
      # @return [Hash]
      #
      # @example
      #   @client.redeem_coupon('5667fb86-69ec-4b9c-97b4-293c5132309c', 'FIRST-ORDER')
      def redeem_coupon(id, coupon_code)
        post("carts/#{id}/coupon", { code: coupon_code })
      end

      # Remove the current pickup option from the cart.
      #
      # @see https://developer.epages.com/beyond-docs/#remove_coupon_from_cart
      #
      # @param id [String] the cart UUID
      #
      # @return [Hash] an empty hash
      #
      # @example
      #   @client.delete('7563919e-5b00-4300-bb59-7f7cbf35f01f')
      def delete_coupon(id)
        super("carts/#{id}/coupon")
      end
    end
  end
end
