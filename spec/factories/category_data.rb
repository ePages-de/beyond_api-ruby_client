FactoryBot.define do  
  factory :category_data, class: Hash do
    name { "Team42 Category" }
    type { "SMART" }
    default_sort { "HIGHEST_PRICE_FIRST" }

    trait :lowest_price_first do
      name { "Category with lowest price first" }
      default_sort { "LOWEST_PRICE_FIRST" }
    end

    initialize_with { attributes }
  end
end