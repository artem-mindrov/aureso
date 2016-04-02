class ErrorsController < ApplicationController
  def routing_error
    render json: { error: "Page not found" }, status: :not_found
  end

  def exception
    render json: { error: "Internal server error" }, status: :internal_server_error
  end
end