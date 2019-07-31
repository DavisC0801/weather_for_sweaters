class Api::V1::UsersController < ApplicationController
  def create
    user = User.new(user_params)
    if user.save
      render json: { "api_key" => user.api_key }, :status => 201
    else

      render json: { "error" => user.errors.full_messages.first }, :status => 401
    end
  end

  private
  def user_params
    recieved_params = params.permit(:email, :password, :password_confirmation)
    recieved_params[:api_key] = SecureRandom.hex(14)
    recieved_params
  end
end
