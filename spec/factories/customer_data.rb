# frozen_string_literal: true

FactoryBot.define do
  factory :customer_data, class: Hash do
    email { 'chayanne@example.com' }
    customer_comment { 'A reliable customer' }

    billing_address do
      {
        company: 'ePages GmbH',
        first_name: 'Chayanne',
        last_name: 'Team42',
        street: 'Pilatuspool',
        house_number: '2',
        postal_code: '20999',
        city: 'Alsterwasser',
        country: 'DE',
        state: 'Hamburg',
        email: 'chayanne@example.com',
        phone: '(800) 555-0102'
      }
    end

    shipping_address do
      {
        gender: 'FEMALE',
        company: 'Astrid Alster GmbH',
        first_name: 'Astrid',
        last_name: 'Alster',
        street: 'Alsterwasserweg',
        house_number: '2',
        postal_code: '20999',
        city: 'Alsterwasser',
        country: 'DE',
        state: 'Hamburg',
        email: 'alsterh@example.com',
        phone: '(800) 555-0102'
      }
    end

    trait :berlin_shipping do
      shipping_address do
        {
          gender: 'FEMALE',
          company: 'Updated GmbH',
          first_name: 'Astrid',
          last_name: 'Alster',
          street: 'Berlin Street',
          house_number: '42',
          postal_code: '12345',
          city: 'Berlin',
          country: 'DE',
          state: 'Berlin',
          email: 'alsterh@example.com',
          phone: '(800) 555-0102'
        }
      end
    end

    initialize_with { attributes }
  end
end
