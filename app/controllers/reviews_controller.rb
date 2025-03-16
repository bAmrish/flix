class ReviewsController < ApplicationController
  before_action :set_movie
  before_action :require_signin, except: [:index]
  before_action :set_review, only: [:edit, :update, :destroy]
  before_action :require_current_user, only: [:edit, :update, :destroy]

  def index
    @reviews =@movie.reviews
  end

  def new
    @review = @movie.reviews.new
    @review.user = current_user
  end

  def create
    @review = @movie.reviews.new(review_params)
    @review.user = current_user

    if @review.save
      redirect_to movie_reviews_path(@movie), notice: 'Review added successfully!'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @review.update(review_params)
      redirect_to movie_reviews_path(@movie), notice: 'Review updated successfully!'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @review.destroy
    redirect_to movie_reviews_path(@movie), status: :see_other, alert: 'Review Deleted Successfully!'
  end
private

  def set_movie
    movie_id = params[:movie_id]
    @movie = Movie.find_by(slug: movie_id)   
  end

  def set_review
    review_id = params[:id]
    @review = Review.find_by(movie: @movie, id: review_id)
  end

  def review_params
    params.require(:review).permit(:stars, :comment)
  end

  def require_current_user    
    redirect_to root_path, alert: 'Unauthorized!' \
        unless is_logged_in_user?(@review.user)
  end
end
