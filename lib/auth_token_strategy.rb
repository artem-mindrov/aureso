require 'token_manager'

class AuthTokenStrategy < ::Warden::Strategies::Base
  def valid?
    user_email.present? && auth_token.present?
  end

  def authenticate!
    email = user_email
    error, user = "Authentication failed for #{email}", User.find_by(email: email)

    return fail!(error) unless user

    token = TokenManager.new.find_token(user, auth_token)
    return fail!(error) unless token

    update_token(token)
    success!(user)
  end

  def store?
    false
  end

  private

  def user_email
    @user_email ||= env["HTTP_X_USER_EMAIL"]
  end

  def auth_token
    @auth_token ||= env["HTTP_X_AUTH_TOKEN"]
  end

  def update_token(token)
    token.update_attribute(:last_used_at, Time.now) if token.last_used_at < 1.hour.ago
  end
end