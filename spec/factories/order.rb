FactoryBot.define do
    factory :order do
      association :user
      association :package
      order_date { Time.now }
      total_amount { 1000.0 }
      stripe_session_id { "session_123" }
      status { "pending" }
    end
  end
