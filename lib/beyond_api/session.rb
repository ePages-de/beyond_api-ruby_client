# frozen_string_literal: true

require "beyond_api/resources/base"
require "beyond_api/resources/carts"
require "beyond_api/resources/categories"
require "beyond_api/resources/checkout_settings"
require "beyond_api/resources/newsletter_target"
require "beyond_api/resources/order_settings"
require "beyond_api/resources/orders"
require "beyond_api/resources/payment_methods"
require "beyond_api/resources/product_attribute_definitions"
require "beyond_api/resources/product_view_categories"
require "beyond_api/resources/product_view_products"
require "beyond_api/resources/products"
require "beyond_api/resources/scopes"
require "beyond_api/resources/script_tags"
require "beyond_api/resources/shipping_zones"
require "beyond_api/resources/shop"
require "beyond_api/resources/token"
require "beyond_api/resources/users"
require "beyond_api/resources/webhook_subscriptions"

module BeyondAPI
  class Session
    attr_reader :api_url
    attr_accessor :access_token, :refresh_token

    def initialize(api_url:, access_token: nil, refresh_token: nil)
      @api_url = api_url
      @access_token = access_token
      @refresh_token = refresh_token
    end

    def carts
      BeyondAPI::Carts.new(self)
    end

    def categories
      BeyondAPI::Categories.new(self)
    end

    def checkout_settings
      BeyondAPI::CheckoutSettings.new(self)
    end

    def order_settings
      BeyondAPI::OrderSettings.new(self)
    end

    def orders
      BeyondAPI::Orders.new(self)
    end

    def newsletter_target
      BeyondAPI::NewsletterTarget.new(self)
    end

    def products
      BeyondAPI::Products.new(self)
    end

    def product_attribute_definitionsd
      BeyondAPI::ProductAttributeDefinition.new(self)
    end

    def product_view_categories
      BeyondAPI::ProductViewCategories.new(self)
    end

    def product_view_products
      BeyondAPI::ProductViewProducts.new(self)
    end

    def scopes
      BeyondAPI::Scopes.new(self)
    end

    def script_tags
      BeyondAPI::ScriptTags.new(self)
    end

    def shipping_zones
      BeyondAPI::ShippingZones.new(self)
    end

    def shop
      BeyondAPI::Shop.new(self)
    end

    def token
      BeyondAPI::Token.new(self)
    end

    def users
      BeyondAPI::Users.new(self)
    end

    def variations
      BeyondAPI::Variations.new(self)
    end

    def webhook_subscriptions
      BeyondAPI::WebhookSubscriptions.new(self)
    end
  end
end
