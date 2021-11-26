class Api::V1::Admin::AnimesController < ApplicationController
  before_action :authenticate_admin
  def index
    anime = current_user.animes
    render jsonapi: anime
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
    authorization_error unless anime
    if anime.update(anime_params)
      render jsonapi: anime, status: :ok
    else
      render jsonapi_errors: anime.errors, status: :unprocessable_entity
    end
  end

  def destroy
    anime = current_user.animes.find(params[:id])
    anime.destroy
    head :no_content
  rescue ActiveRecord::RecordNotFound
    authorization_error
  end

  private

  def anime_params
    params.permit(:name, :description, :header_image, :rating, :genre_list)
  end
end
