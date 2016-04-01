FactoryGirl.define do
  factory :model_type do
    model
    sequence(:name) { |n| "Model type #{n}" }
    base_price 100
  end
end
