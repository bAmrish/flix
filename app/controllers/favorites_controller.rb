class FavoritesController < ApplicationController
  before_action :require_signin
  before_action :set_movie

  def create  
    fave = current_user.favorites.find_by(movie: @movie)
    @movie.favorites.create(user: current_user) unless fave
    redirect_to @movie
  end

  def destroy
    fave = current_user.favorites.find_by(movie: @movie)
    fave.destroy
    redirect_to @movie
  end

private
  def set_movie
    @movie = Movie.find_by(slug: params[:movie_id])
  end

end
