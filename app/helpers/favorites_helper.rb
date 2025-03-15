module FavoritesHelper
  def fave_button (movie, fave)
    if @fave
      button_to "♡ Unfav", movie_favorite_path(movie, fave), method: :delete 
    else 
      button_to "♥️ Fave", movie_favorites_path(movie)
    end
  end
end
