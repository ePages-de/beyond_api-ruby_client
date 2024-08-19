FactoryBot.define do
  factory :webhook_data, class: Hash do
    callback_uri { "http://example.com/test" }
    event_types { ["order.created", "product.created"] }

    initialize_with { attributes }
  end
end
