class ReviewsController < ApplicationController
  before_action :set_movie
  before_action :require_signin, except: [:index]

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
    review_id = params[:id]
    @review = Review.find(review_id)
  end

  def update
    review_id = params[:id]
    @review = Review.find_by(movie: @movie, id: review_id)
    if @review.update(review_params)
      redirect_to movie_reviews_path(@movie), notice: 'Review updated successfully!'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    review_id = params[:id]
    @review = Review.find_by(movie: @movie, id: review_id)
    @review.destroy
    redirect_to movie_reviews_path(@movie), status: :see_other, alert: 'Review Deleted Successfully!'
  end
private

  def set_movie
    movie_id = params[:movie_id]
    @movie = Movie.find(movie_id)   
  end

  def review_params
    params.require(:review).permit(:stars, :comment)
  end
end
