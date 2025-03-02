module MoviesHelper
  def total_gross(movie)
    if movie.flop?
      "Flop"
    else
      number_to_currency(movie.total_gross, precision: 0, unit: "USD ")
    end
  end

  def release_date(movie)
    movie.released_on.strftime("%B %e, %Y")
  end

end
