# frozen_string_literal: true

require "beyond_api/resources/base"
require "beyond_api/resources/carts"
require "beyond_api/resources/categories_view"
require "beyond_api/resources/categories"
require "beyond_api/resources/checkout_settings"
require "beyond_api/resources/newsletter_target"
require "beyond_api/resources/order_settings"
require "beyond_api/resources/orders"
require "beyond_api/resources/payment_methods"
require "beyond_api/resources/product_attribute_definitions"
require "beyond_api/resources/product_settings"
require "beyond_api/resources/products_view"
require "beyond_api/resources/products"
require "beyond_api/resources/scopes"
require "beyond_api/resources/script_tags"
require "beyond_api/resources/shipping_zones"
require "beyond_api/resources/shop"
require "beyond_api/resources/token"
require "beyond_api/resources/users"
require "beyond_api/resources/variations"
require "beyond_api/resources/webhook_subscriptions"

module BeyondApi
  class Session
    attr_reader :api_url
    attr_accessor :access_token, :refresh_token

    def initialize(api_url:, access_token: nil, refresh_token: nil)
      @api_url = api_url
      @access_token = access_token
      @refresh_token = refresh_token
    end

    def carts
      BeyondApi::Carts.new(self)
    end

    def categories_view
      BeyondApi::CategoriesView.new(self)
    end

    def categories
      BeyondApi::Categories.new(self)
    end

    def checkout_settings
      BeyondApi::CheckoutSettings.new(self)
    end

    def newsletter_target
      BeyondApi::NewsletterTarget.new(self)
    end

    def order_settings
      BeyondApi::OrderSettings.new(self)
    end

    def orders
      BeyondApi::Orders.new(self)
    end

    def payment_methods
      BeyondApi::PaymentMethods.new(self)
    end

    def product_attribute_definitions
      BeyondApi::ProductAttributeDefinitions.new(self)
    end

    def product_settings
      BeyondApi::ProductSettings.new(self)
    end

    def products_view
      BeyondApi::ProductsView.new(self)
    end

    def products
      BeyondApi::Products.new(self)
    end

    def scopes
      BeyondApi::Scopes.new(self)
    end

    def script_tags
      BeyondApi::ScriptTags.new(self)
    end

    def shipping_zones
      BeyondApi::ShippingZones.new(self)
    end

    def shop
      BeyondApi::Shop.new(self)
    end

    def token
      BeyondApi::Token.new(self)
    end

    def users
      BeyondApi::Users.new(self)
    end

    def variations
      BeyondApi::Variations.new(self)
    end

    def webhook_subscriptions
      BeyondApi::WebhookSubscriptions.new(self)
    end
  end
end
