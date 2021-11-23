class Api::V1::Admin::UsersController < ApplicationController
  before_action :authenticate_admin
  before_action :set_user, except: %i[index]

  def index
    users = User.where.not(id: current_user.id)
    render jsonapi: users
  end

  def make_admin
    errors = {
      'status' => '404',
      'source' => { 'pointer' => '/headers/forbidden' },
      'title' => 'Forbidden',
      'detail' => 'Already Admin'
    }
    if @user.admin?
      render json: { errors: errors }, status: 404
    else
      @user.update(admin: true)
      render jsonapi: @user, status: :created
    end
  end

  def remove_admin
    errors = {
      'status' => '404',
      'source' => { 'pointer' => '/headers/forbidden' },
      'title' => 'Forbidden',
      'detail' => 'Not an Admin'
    }
    if @user.admin?
      @user.update(admin: false)
      render jsonapi: @user, status: :created
    else
      render json: { errors: errors }, status: 404
    end
  end

  def destroy
    errors = {
      'status' => '403',
      'source' => { 'pointer' => '/headers/authorization' },
      'title' => 'Not authorized',
      'detail' => 'Can\'t delete current user or admins'
    }

    if @user.id == current_user.id || @user.admin?
      render json: { errors: errors }, status: 403
    else
      @user.destroy
      head :no_content
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
