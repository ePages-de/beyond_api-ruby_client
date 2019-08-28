# frozen_string_literal: true

require "beyond_api/resources/base"
require "beyond_api/resources/carts"
require "beyond_api/resources/categories"
require "beyond_api/resources/checkout_settings"
require "beyond_api/resources/product_view_categories"
require "beyond_api/resources/products"
require "beyond_api/resources/token"
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

    def product_view_categories
      BeyondAPI::ProductViewCategories.new(self)
    end

    def products
      BeyondAPI::Products.new(self)
    end

    def shop
      BeyondAPI::Shop.new(self)
    end

    def token
      BeyondAPI::Token.new(self)
    end

    def webhook_subscriptions
      BeyondAPI::WebhookSubscriptions.new(self)
    end
  end
end
