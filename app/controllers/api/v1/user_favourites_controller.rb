class Api::V1::UserFavouritesController < ApplicationController
  def index
    current_user_favorites = current_user.favorite_anime
    render jsonapi: current_user_favorites
  end
end