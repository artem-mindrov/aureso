class TokenManager
  def self.create_token(resource, request)
    new.create_token(resource, request)
  end

  def self.expire_token(resource, request)
    new.expire_token(resource, request)
  end

  def self.purge_tokens(resource)
    new.purge_tokens(resource)
  end

  def create_token(resource, request)
    resource.auth_tokens.create!(last_used_at: Time.now, ip: request.remote_ip, user_agent: request.user_agent).body
  end

  def expire_token(resource, request)
    find_token(resource, request.headers["X-Auth-Token"]).try(:destroy)
  end

  def find_token(resource, token_from_headers)
    resource.auth_tokens.detect { |token| token.body == token_from_headers }
  end

  def purge_tokens(resource)
    resource.auth_tokens.order(last_used_at: :desc).destroy_all
  end
end