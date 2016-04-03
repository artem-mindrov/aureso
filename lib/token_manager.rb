class TokenManager
  def self.create(resource, request)
    new.create(resource, request)
  end

  def self.purge(resource)
    new.purge(resource)
  end

  def self.expire(resource, request)
    new.expire(resource, request)
  end

  def create(resource, request)
    resource.auth_tokens.create!(last_used_at: Time.now, ip: request.remote_ip, user_agent: request.user_agent).body
  end

  def find(resource, token_from_headers)
    resource.auth_tokens.detect { |token| token.body == token_from_headers }
  end

  def purge(resource)
    resource.auth_tokens.order(last_used_at: :desc).destroy_all
  end

  def expire(resource, request)
    find(resource, request.headers["HTTP_X_AUTH_TOKEN"]).try(:destroy)
  end
end