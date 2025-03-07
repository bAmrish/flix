class ReviewsController < ApplicationController

  def index
    movie_id = params[:movie_id]
    @movie = Movie.find(movie_id)
    @reviews =@movie.reviews
  end
end
