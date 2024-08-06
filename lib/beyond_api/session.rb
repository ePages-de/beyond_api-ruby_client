# frozen_string_literal: true

module BeyondApi
  class Session
    class InvalidUriProtocolError < StandardError; end

    attr_reader :api_url
    attr_accessor :access_token, :refresh_token

    def initialize(api_url:, access_token: nil, refresh_token: nil)
      raise InvalidUriProtocolError, "Invalid URI protocol" unless api_url.start_with? "https://"

      uri = URI.parse(api_url)

      @api_url = "#{uri.scheme}://#{uri.host}/api"
      @access_token = access_token
      @refresh_token = refresh_token
    end

    def carts
      Carts.new(self)
    end

    def categories_view
      CategoriesView.new(self)
    end

    def categories
      Categories.new(self)
    end

    def checkout_settings
      CheckoutSettings.new(self)
    end

    def customers
      Customers.new(self)
    end

    def newsletter_target
      NewsletterTarget.new(self)
    end

    def order_settings
      OrderSettings.new(self)
    end

    def orders
      Orders.new(self)
    end

    def payment_method_definitions
      PaymentMethodDefinitions.new(self)
    end

    def payment_methods
      PaymentMethods.new(self)
    end

    def pickup_options
      PickupOptions.new(self)
    end

    def product_attribute_definitions
      ProductAttributeDefinitions.new(self)
    end

    def products_view
      ProductsView.new(self)
    end

    def products
      Products.new(self)
    end

    def script_tags
      ScriptTags.new(self)
    end

    def shipping_zones
      ShippingZones.new(self)
    end

    def shop
      Shop.new(self)
    end

    def signers
      Signers.new(self)
    end

    def token
      Token.new(self)
    end

    def users
      Users.new(self)
    end

    def variations
      Variations.new(self)
    end

    def webhook_subscriptions
      WebhookSubscriptions.new(self)
    end
  end
end
