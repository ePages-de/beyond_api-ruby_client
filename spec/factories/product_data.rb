# frozen_string_literal: true

FactoryBot.define do
  factory :product_data, class: Hash do
    name { 'Team42 Product' }
    description { "Spain\nRioja Tempranillo" }
    manufacturer { 'Grape Vineyard' }
    essential_features { 'Dry. 12% alcohol. Best vine variety.' }
    tags { ['Bestseller', 'Red Wine', 'Sale'] }

    product_identifiers do
      [
        {
          type: 'EAN',
          value: '9780134308135'
        }
      ]
    end

    sales_price do
      {
        tax_model: 'GROSS',
        amount: 8.7,
        currency: 'GBP'
      }
    end

    list_price do
      {
        tax_model: 'GROSS',
        amount: 10.95,
        currency: 'GBP'
      }
    end

    manufacturer_price do
      {
        tax_model: 'GROSS',
        amount: 11.95,
        currency: 'GBP'
      }
    end

    visible { true }
    tax_class { 'REGULAR' }

    shipping_weight do
      {
        value: 1175.0,
        display_unit: 'GRAMS'
      }
    end

    max_order_quantity { 6 }

    shipping_dimension do
      {
        length: 1500,
        width: 1000,
        height: 2000
      }
    end

    ref_price do
      {
        ref_quantity: 1,
        unit: 'LITER',
        quantity: 0.75,
        price: {
          tax_model: 'GROSS',
          amount: 11.6,
          currency: 'GBP'
        }
      }
    end

    shipping_period do
      {
        min: 2,
        max: 4,
        display_unit: 'WEEKS'
      }
    end

    pickup_period do
      {
        min: 1,
        max: 2,
        display_unit: 'WEEKS'
      }
    end

    product_labels do
      [
        {
          type: 'NEW',
          active_from: '2024-08-13T11:31:30.210787732',
          active_until: '2024-09-10T11:31:30.210787732'
        }
      ]
    end

    initialize_with { attributes }
  end
end
