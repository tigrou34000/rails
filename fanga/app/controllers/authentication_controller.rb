class AuthenticationController < ApplicationController
  skip_before_action :authenticate_request

  def authenticate
    command = AuthenticateUser.call(params[:email], params[:password])

    if command.success?
      render json: { auth_token: command.result, user_id: JsonWebToken.decode(command.result)['user_id'] }
    else
      render json: { error: command.errors }, status: :unauthorized oo
    end
  end
end