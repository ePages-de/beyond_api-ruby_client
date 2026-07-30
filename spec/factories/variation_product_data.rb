# frozen_string_literal: true

# Static (non-Faker) data so the request bodies stay byte-identical across runs
# and VCR can match on :body when replaying the cassettes.
FactoryBot.define do
  factory :variation_product_data, class: Hash do
    name { 'Team42 Variation Product' }
    description { '100% cotton, regular fit, needs cold washing (max. 30°C).' }
    manufacturer { 'Tony Highfinger' }
    tags { %w[Shirt Summer Sale] }
    product_identifiers { [] }
    visible { true }
    tax_class { 'REGULAR' }

    sales_price do
      {
        tax_model: 'GROSS',
        amount: 29.99,
        currency: 'GBP'
      }
    end

    list_price do
      {
        tax_model: 'GROSS',
        amount: 39.99,
        currency: 'GBP'
      }
    end

    manufacturer_price do
      {
        tax_model: 'GROSS',
        amount: 40.99,
        currency: 'GBP'
      }
    end

    shipping_weight do
      {
        value: 100.0,
        display_unit: 'GRAMS'
      }
    end

    shipping_dimension do
      {
        length: 2000,
        width: 750,
        height: 500
      }
    end

    shipping_period do
      {
        min: 3,
        max: 5,
        display_unit: 'DAYS'
      }
    end

    pickup_period do
      {
        min: 1,
        max: 3,
        display_unit: 'DAYS'
      }
    end

    variation_attributes do
      [
        { display_name: 'size', values: %w[S M] },
        { display_name: 'color', values: %w[Black White] }
      ]
    end

    # A single differentiating attribute, which keeps the number of generated
    # variations (and therefore the cassettes) small.
    trait :single_attribute do
      variation_attributes do
        [{ display_name: 'size', values: %w[S M] }]
      end
    end

    initialize_with { attributes }
  end
end
