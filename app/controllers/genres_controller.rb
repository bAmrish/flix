class GenresController < ApplicationController
  def index
    @genres = Genre.all
  end

  def create
    @genre = Genre.new(genre_params)
    if @genre.save
      redirect_to genres_path, status: :see_other, notice: 'Genre added successfully'
    else
      @genres = Genre.all
      render :index, status: :unprocessable_entity
    end
  end

  def destroy
    @genre = Genre.find(params[:id])
    @genre.destroy
    redirect_to genres_path, status: :see_other, alert: 'Genre deleted successfully'
  end

private
  def genre_params
    params.permit(:name)
  end
end
