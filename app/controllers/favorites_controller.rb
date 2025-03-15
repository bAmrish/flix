class FavoritesController < ApplicationController
  before_action :require_signin
  before_action :set_movie

  def create  
    @movie.favorites.create(user: current_user)
    redirect_to @movie
  end

  def destroy
    like = current_user.favorites.find_by(movie: @movie)
    like.destroy
    redirect_to @movie
  end

private
  def set_movie
    @movie = Movie.find(params[:movie_id])
  end

end
