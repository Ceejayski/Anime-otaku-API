class Api::V1::AnimesController < ApplicationController
  skip_before_action :authenticate_request
  def index
    animes = Anime.highest_rated
    render jsonapi: animes
  end

  def show
    render jsonapi: Anime.find(params[:id])
  end
end
