class AuthToken < ActiveRecord::Base
  belongs_to :user
  has_secure_token :body
  validates :body, :ip, :user_agent, presence: true
end
