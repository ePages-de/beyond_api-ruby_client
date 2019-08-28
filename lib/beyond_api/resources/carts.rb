# frozen_string_literal: true

require "beyond_api/utils"

module BeyondAPI
  class Carts < Base
    include BeyondAPI::Utils

    #
    # A +POST+ request is used to create a cart.
    #
    # @scope
    #
    # @return [OpenStruct]
    #
    # @example
    #   @cart = session.carts.create
    #
    def create(body)
      response, status = BeyondAPI::Request.post(@session, "/carts", body)

      handle_response(response, status)
    end

    #
    # A +GET+ request is used to retrieve the details of a cart.
    #
    # @param cart_id [String] the cart UUID
    #
    # @return [OpenStruct]
    #
    # @example
    #   @cart = session.carts.find("26857145-aeab-4210-9191-3906573a14ae")
    #
    def find(cart_id)
      response, status = BeyondAPI::Request.get(@session, "/carts/#{cart_id}")

      handle_response(response, status)
    end

    #
    # A +DELETE+ request is used to delete a cart.
    #
    # @param cart_id [String] the cart UUID
    #
    # @return true
    #
    # @example
    #   session.carts.delete("1a58f22f-481a-4993-9947-62c1c2857f87")
    #
    def delete(cart_id)
      response, status = BeyondAPI::Request.delete(@session, "/carts/#{cart_id}")

      handle_response(response, status, respond_with_true: true)
    end

    #
    # A +POST+ request is used to create an order from the cart.
    #
    # @scope
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
    #   @cart = session.carts.create("986247da-b78f-422c-a273-917804896974", body)
    #
    def create_order(cart_id, body)
      response, status = BeyondAPI::Request.post(@session, "/carts/#{cart_id}/order", body)

      handle_response(response, status)
    end

    #
    # A +POST+ request is used to add a line item to the cart. Currently only product line items are supported.
    #
    # @scope
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
      response, status = BeyondAPI::Request.post(@session, "/carts/#{cart_id}/line-items", body)

      handle_response(response, status)
    end

    #
    # A +PUT+ request is used to replace only one line item in the cart.
    #
    # @scope
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
    #   @cart = session.carts.replace_line_item("6d529573-b39e-4cd4-99fe-856432ea97f3", body)
    #
    def replace_line_item(cart_id, line_item_id, body)
      response, status = BeyondAPI::Request.put(@session, "/carts/#{cart_id}/line-items/#{line_item_id}", body)

      handle_response(response, status)
    end

    #
    # A +PUT+ request is used to replace the current line items in the cart with the given list.
    #
    # @scope
    #
    # @param cart_id [String] the cart UUID
    # @param body [String] the JSON array of line items
    #
    # @return [OpenStruct]
    #
    # @example
    #   body = '[{"_type":"PRODUCT","_ref":"0612362d-9856-4b40-94c6-a36abec0cf8c","quantity":1}]'
    #   @cart = session.carts.replace_line_item("c1436110-e283-49b3-a748-0321efec6d35", body)
    #
    def replace_line_items(cart_id, body)
      response, status = BeyondAPI::Request.put(@session, "/carts/#{cart_id}/line-items", body)

      handle_response(response, status)
    end

    #
    # A +DELETE+ request is used to delete a webhook subscription.
    #
    # @param webhook_subscription_id [String] the webhook subscription UUID
    #
    # @return true
    #
    # @example
    #   session.carts.delete_line_item("3fb55475-f6d2-471a-90ac-ccee7896b9f7")
    #
    def delete_line_item(cart_id, line_item_id)
      response, status = BeyondAPI::Request.delete(@session, "/carts/#{cart_id}/line-items/#{line_item_id}")

      handle_response(response, status, respond_with_true: true)
    end

    def set_billing_address(cart_id, body)
      response, status = BeyondAPI::Request.put(@session, "/carts/#{cart_id}/billing-address", body)

      handle_response(response, status)
    end

    def set_shipping_address(cart_id, body)
      response, status = BeyondAPI::Request.put(@session, "/carts/#{cart_id}/shipping-address", body)

      handle_response(response, status)
    end

    def delete_shipping_address(cart_id)
      response, status = BeyondAPI::Request.delete(@session, "/carts/#{cart_id}/shipping-address")

      handle_response(response, status, respond_with_true: true)
    end

    def set_payment_method(cart_id, payment_method_id)
      response, status = BeyondAPI::Request.put(@session, "/carts/#{cart_id}/payment-methods/current",
                                          "#{@session.api_url}/payment-methods/#{payment_method_id}")

      handle_response(response, status)
    end

    def set_payment_method_to_default(cart_id)
      response, status = BeyondAPI::Request.put(@session, "/carts/#{cart_id}/payment-methods/default")

      handle_response(response, status)
    end

    def payment_method(cart_id)
      response, status = BeyondAPI::Request.get(@session, "/carts/#{cart_id}/payment-methods/current")

      handle_response(response, status)
    end

    def payment_methods(cart_id)
      response, status = BeyondAPI::Request.get(@session, "/carts/#{cart_id}/payment-methods")

      handle_response(response, status)
    end

    def create_payment(cart_id, body)
      response, status = BeyondAPI::Request.post(@session, "/carts/#{cart_id}/create-payment", body)

      handle_response(response, status)
    end

    def create_payment_and_order(cart_id, body)
      response, status = BeyondAPI::Request.post(@session, "/carts/#{cart_id}/create-payment-and-order", body)

      handle_response(response, status)
    end
  end
end
