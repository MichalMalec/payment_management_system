FactoryBot.define do
    factory :package do
      name { "Basic Plan" }
      price { 1000.0 }
      stripe_price_id { "price_123" }
    end
  end
