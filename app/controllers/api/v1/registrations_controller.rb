class Api::V1::RegistrationsController < ApplicationController
  skip_before_action :authenticate_request

  def create
    user = User.new(registration_params)
    user.save!
    command = AuthenticateUser.call(user.email, user.password)
    render json: {auth_token: command.result[:auth_token], username: user.username, admin: user.admin, message: 'Signed up Successfully' }, status: :created
  rescue ActiveRecord::RecordInvalid
    render  jsonapi_errors: user.errors, status: :unprocessable_entity
  end

  private

  def registration_params
    params.require(:data).require(:attributes)
          .permit(:email, :password, :password_confirmation, :username) ||
      ActionController::Parameters.new
  end
end
