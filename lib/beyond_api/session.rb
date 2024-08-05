# frozen_string_literal: true

module BeyondApi
  autoload :Base,                        "beyond_api/resources/base"
  autoload :Carts,                       "beyond_api/resources/carts"
  autoload :CategoriesView,              "beyond_api/resources/categories_view"
  autoload :Categories,                  "beyond_api/resources/categories"
  autoload :CheckoutSettings,            "beyond_api/resources/checkout_settings"
  autoload :Customers,                   "beyond_api/resources/customers"
  autoload :NewsletterTarget,            "beyond_api/resources/newsletter_target"
  autoload :OrderSettings,               "beyond_api/resources/order_settings"
  autoload :Orders,                      "beyond_api/resources/orders"
  autoload :PaymentMethodDefinitions,    "beyond_api/resources/payment_method_definitions"
  autoload :PickupOptions,               "beyond_api/resources/pickup_options"
  autoload :PaymentMethods,              "beyond_api/resources/payment_methods"
  autoload :ProductAttributeDefinitions, "beyond_api/resources/product_attribute_definitions"
  autoload :ProductsView,                "beyond_api/resources/products_view"
  autoload :Products,                    "beyond_api/resources/products"
  autoload :ScriptTags,                  "beyond_api/resources/script_tags"
  autoload :ShippingZones,               "beyond_api/resources/shipping_zones"
  autoload :Shop,                        "beyond_api/resources/shop"
  autoload :Signers,                     "beyond_api/resources/signers"
  autoload :Token,                       "beyond_api/resources/token"
  autoload :Users,                       "beyond_api/resources/users"
  autoload :Variations,                  "beyond_api/resources/variations"
  autoload :WebhookSubscriptions,        "beyond_api/resources/webhook_subscriptions"

  autoload :BaseService,                        "beyond_api/services/base_service"
  # autoload "ProductView::Category",                 "beyond_api/services/product_view/category"
  # autoload "ProductView::Category",                 "beyond_api/services/product_view/category"


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

    def customers
      BeyondApi::Customers.new(self)
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

    def payment_method_definitions
      BeyondApi::PaymentMethodDefinitions.new(self)
    end

    def payment_methods
      BeyondApi::PaymentMethods.new(self)
    end

    def pickup_options
      BeyondApi::PickupOptions.new(self)
    end

    def product_attribute_definitions
      BeyondApi::ProductAttributeDefinitions.new(self)
    end

    def products_view
      BeyondApi::ProductsView.new(self)
    end

    def products
      BeyondApi::Products.new(self)
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

    def signers
      BeyondApi::Signers.new(self)
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
