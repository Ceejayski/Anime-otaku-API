class Api::V1::UserFavouritesController < ApplicationController
  def index
    current_user_favorites = current_user.favorite_anime
    render jsonapi: current_user_favorites
  end

  def destroy
    current_user_favorite = current_user.favorites.find_by(anime_id: params[:id])
    current_user_favorite.destroy
    head :no_content
  rescue StandardError
    authorization_error
  end
end
