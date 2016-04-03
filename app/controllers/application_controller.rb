class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  helper_method :warden, :current_user
  prepend_before_action :authenticate!

  def current_user
    warden.user
  end

  def warden
    request.env['warden']
  end

  def authenticate!
    warden.authenticate!
  end

  private

  def not_found(error)
    render json: { error: error.message }, status: :not_found
  end
end
