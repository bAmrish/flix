module ReviewsHelper
  def average_stars(movie)
    if movie.average_stars == "0.0"
      content_tag :b, "No Reviews"
    else
      pluralize( number_with_precision(movie.average_stars, precision: 1), "star")
    end
  end
end
