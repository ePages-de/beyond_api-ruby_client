# frozen_string_literal: true

FactoryBot.define do
  factory :location_data, class: Hash do
    language_code { 'en' }
    store_code { 'MLC-St-Ives' }
    company_name { 'My little Cornershop - St.Ives' }
    primary_phone { '(800) 555-0102' }

    address do
      {
        postal_code: '90999',
        street: 'Hudson Way',
        house_number: '27',
        city: 'St.Ives',
        country: 'GB',
        dependent_locality: '',
        state: 'Cornwall'
      }
    end

    google_status { 'ACTIVE' }

    google_primary_category do
      {
        category_id: 'gcid:storefood',
        display_name: 'Food'
      }
    end

    google_additional_categories do
      [
        {
          display_name: 'Drinks',
          category_id: 'gcid:storedrinks'
        }
      ]
    end

    regular_hours do
      {
        periods: [
          {
            open_day: 'MONDAY',
            open_time: '08:00',
            close_day: 'MONDAY',
            close_time: '17:00'
          },
          {
            open_day: 'SATURDAY',
            open_time: '10:00',
            close_day: 'SATURDAY',
            close_time: '16:00'
          }
        ]
      }
    end

    lat_lng do
      {
        latitude: 53.5847424,
        longitude: 9.968901
      }
    end

    trait :alternative_name do
      company_name { 'Updated Cornershop' }
    end

    initialize_with { attributes }
  end
end
