# frozen_string_literal: true

FactoryBot.define do
  factory :address_data, class: Hash do
    salutation { 'Mrs' }
    gender { 'FEMALE' }
    title { 'Dr' }
    first_name { 'Astrid' }
    middle_name { 'Agnes' }
    last_name { 'Alster' }
    street { 'Alsterwasserweg' }
    house_number { '2' }
    street2 { 'Erdgeschoss' }
    door_code { '0185' }
    address_extension { 'Hinterhof' }
    postal_code { '20999' }
    dependent_locality { 'Seevetal' }
    city { 'Alsterwasser' }
    country { 'DE' }
    state { 'Hamburg' }
    email { 'a.alsterh@example.com' }
    phone { '(800) 555-0102' }
    mobile { '(800) 555-0103' }
    vat_id { '123456789' }
    tax_number { '123-34-6789' }
    birth_date { '1985-03-20' }

    initialize_with { attributes }
  end
end
