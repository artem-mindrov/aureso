require 'auth_token_strategy'

Warden::Strategies.add(:auth_token, AuthTokenStrategy)

Rails.application.config.middleware.insert_after ActionDispatch::ParamsParser, Warden::Manager do |manager|
  manager.default_strategies :auth_token
  manager.failure_app = ErrorsController
end