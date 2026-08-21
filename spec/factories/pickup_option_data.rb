# frozen_string_literal: true

FactoryBot.define do
  factory :pickup_option_data, class: Hash do
    name { 'My little Cornershop - St.Ives' }
    description do
      'We will send you an email when your items are ready for pickup. ' \
        'Please bring a copy of your order confirmation.'
    end
    tax_class { 'REGULAR' }
    phone_number_required { true }

    free_pickup_value do
      {
        currency: 'EUR',
        amount: 50
      }
    end

    fixed_price do
      {
        tax_model: 'GROSS',
        currency: 'EUR',
        amount: 1
      }
    end

    trait :alternative_name do
      name { 'Updated Cornershop' }
    end

    trait :without_name do
      name { nil }
    end

    initialize_with { attributes }
  end
end
