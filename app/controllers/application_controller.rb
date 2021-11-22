class ApplicationController < ActionController::API
  before_action :authenticate_request
  attr_reader :current_user

  private

  def authenticate_request
    @current_user = AuthorizeApiRequest.call(request.headers).result
    authorization_error unless @current_user
  end

  def authorization_error
    errors = {
      'status' => '403',
      'source' => { 'pointer' => '/headers/authorization' },
      'title' => 'Not authorized',
      'detail' => 'Only Admins can perform such action'
    }
    render json: { errors: [errors] }, status: 403
  end
end
