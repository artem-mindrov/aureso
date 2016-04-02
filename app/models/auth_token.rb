class AuthToken < ActiveRecord::Base
  belongs_to :user
  has_secure_token :body
  validates :body, :ip, :user_agent, presence: true

  before_create { self.last_used_at ||= Time.now }
end
