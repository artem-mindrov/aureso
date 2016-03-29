FactoryGirl.define do
  factory :organization do
    pricing_policy { Organization.pricing_policies.keys.sample }
    sequence(:name) { |n| "Car Manufacturer #{n}" }
    public_name "Public Name"
  end
end
