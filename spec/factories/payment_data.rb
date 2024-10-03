# frozen_string_literal: true

FactoryBot.define do
  factory :payment_data, class: Hash do
    initialize_with {
      {
        return_uri: 'https://example.com/return',
        cancel_uri: 'https://example.com/cancel',
        customer_comment: 'Please send with UPS.',
        sales_channel: 'Storefront',
        marketing_channel: 'Google Shopping',
        marketing_subchannel: 'Summer Sale',
        test_order: false,
        terms_and_conditions_explicitly_accepted: true
      }
    }
  end
end
