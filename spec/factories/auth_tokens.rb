FactoryGirl.define do
  factory :auth_token do
    user
    body "token"
    ip "127.0.0.1"
    user_agent "Chrome"
  end
end
