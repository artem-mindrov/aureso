FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@email.com" }
    password 'af3714ff0ffae'
  end
end