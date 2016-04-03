class SessionsController < ApplicationController
  skip_before_action :authenticate!, only: [:create]

  def create
    user = User.find_by(email: session_params[:email])

    if user && user.authenticate(session_params[:password])
      render json: { user_email: user.email, auth_token: TokenManager.create_token(user, request) }, status: :ok
    else
      render json: "", status: :unauthorized
    end
  end

  def destroy
    TokenManager.expire_token(current_user, request) if current_user
    render json: "", status: :ok
  end

  private

  def session_params
    params.require(:user).permit(:email, :password)
  end
end
