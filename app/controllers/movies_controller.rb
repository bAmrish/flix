class MoviesController < ApplicationController

  before_action :require_signin, except: [:index, :show]
  before_action :require_admin, except: [:index, :show]
  before_action :set_movie, only: [:show, :edit, :update, :destroy]

  def index
    filter = params[:filter]
    
    case filter
    when "upcoming"
      @movies = Movie.upcoming
    when "flops"
      @movies = Movie.flops
    when "hits"
      @movies = Movie.hits
    else
      @movies = Movie.released
    end
  end

  def show
    @fans = @movie.fans
    if is_logged_in?
      @fave = current_user.favorites.find_by(movie: @movie)
    end
    @genres = @movie.genres.order(:name)
  end

  def edit
  end

  def update
    if @movie.update(movie_params)
      redirect_to @movie, notice: 'Movie updated successfully!'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def new
    @movie = Movie.new
  end

  def create
    @movie = Movie.new(movie_params)
    if @movie.save
      redirect_to @movie, notice: 'Movie created successfully!'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @movie.destroy
    redirect_to movies_path, status: :see_other, alert: 'Movie deleted successfully!'
  end
private

  def movie_params
    params.require(:movie).permit(
      :title, :rating, :description, :total_gross, :released_on,
      :director, :duration, genre_ids: []
    )
  end

  def set_movie
    @movie = Movie.find_by(slug: params[:id])
  end

end
