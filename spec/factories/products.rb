# frozen_string_literal: true

require "faker"

FactoryBot.define do
  factory :product, class: Hash do
    name { Faker::Name.name }
    description { Faker::Lorem.paragraph }
    manufacturer { Faker::Company.name }
    essential_features { Faker::Lorem.paragraph }
    tags { Faker::Lorem.words(number: 3).push("beyond_api-ruby_client") }

    default = {
      sales_price: {
        tax_model: "GROSS",
        amount: 8.7,
        currency: "GBP"
      },
      list_price: {
        tax_model: "GROSS",
        amount: 10.95,
        currency: "GBP"
      },
      manufacturer_price: {
        tax_model: "GROSS",
        amount: 99.95,
        currency: "GBP"
      },
      shipping_dimension: {
        length: 1500,
        width: 1000,
        height: 2000
      },
      ref_price: {
        ref_quantity: 1,
        unit: "LITER",
        quantity: 0.75,
        price: {
          tax_model: "GROSS",
          amount: 11.6,
          currency: "GBP"
        }
      },
      shipping_period: {
        min: 2,
        max: 4,
        display_unit: "WEEKS"
      },
      pickup_period: {
        min: 1,
        max: 2,
        display_unit: "WEEKS"
      }
    }

    visible { true }
    shipping_weight { 100 }
    maxOrder_quantity { 6 }

    initialize_with { default.merge(attributes) }

    trait :with_variations do
      variation_attributes do
        [
          { display_name: "size", values: %w[s m] },
          { display_name: "color", values: %w[red green blue] }
        ]
      end
    end
  end
end
