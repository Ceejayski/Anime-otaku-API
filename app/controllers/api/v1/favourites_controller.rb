class Api::V1::FavouritesController < ApplicationController
  def index
    current_user_favorites = current_user.favorite_anime
    render jsonapi: current_user_favorites
  end

  def create
    if already_favourite?
      render json: { message: 'Already in favourites' }, status: 409
    else
      @favorite = current_user.favourites.create!(anime_id: params[:anime_id])
      favorite_anime = current_user.favourites.last
      render jsonapi: favorite_anime, status: 201
    end
  end

  def destroy
    @favorite = current_user.favourites.find(params[:id])
    @favorite.destroy
    head :no_content
  rescue StandardError
    authorization_error
  end

  private

  def already_favourite?
    Favourite.where(user_id: current_user.id, anime_id:
      params[:anime_id]).exists?
  end
end
