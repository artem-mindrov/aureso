class ErrorsController < ApplicationController
  skip_before_action :authenticate!

  def routing_error
    respond("Page not found", :not_found)
  end

  def exception
    respond("Internal server error", :internal_server_error)
  end

  private

  def respond(message, status)
    render json: { error: message }, status: status
  end
end