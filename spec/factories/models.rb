FactoryGirl.define do
  factory :model do
    organization
    sequence(:name) { |n| "Model #{n}" }
  end
end
