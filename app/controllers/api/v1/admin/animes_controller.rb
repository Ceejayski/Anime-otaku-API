class Api::V1::Admin::AnimesController < ApplicationController
  before_action :authenticate_admin
  def index
    user = user.all
    render jsonapi: user
  end

  def create
    anime = current_user.animes.build(anime_params)
    anime.save!
    render jsonapi: anime, status: :created
  rescue StandardError
    render jsonapi_errors: anime.errors, status: :unprocessable_entity
  end

  def update
    anime = current_user.animes.find(params[:id])
    anime.update_attributes!(anime_params)
    render jsonapi: anime, status: :ok
  rescue ActiveRecord::RecordNotFound
    authorization_error
  rescue StandardError
    render jsonapi_errors: anime.errors, status: :unprocessable_entity
  end

  def destroy
    anime = Anime.find(params[:id])
    anime.destroy
    head :no_content
  rescue ActiveRecord::RecordNotFound
    authorization_error
  end

  private

  def anime_params
    params.require(:data).require(:attributes)
      .permit(:name, :description, :header_image, :rating, :genre_list) ||
      ActionController::Parameters.new
  end
end
