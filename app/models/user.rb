class User < ActiveRecord::Base
  has_many :auth_tokens
  has_secure_password
  validates :password, length: { minimum: 8 }
  validates :email, :password_digest, presence: true
  validates :email, uniqueness: true, format: { with: /.+@.+\..+/i }
end
