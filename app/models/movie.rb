class Movie < ApplicationRecord

  has_many :reviews, dependent: :destroy
  has_many :favorites, dependent: :destroy

  RATINGS = %w"G PG PG-13 R NC-17"
  validates :title, presence: true
  validates :released_on, presence: true
  validates :duration, presence: true
  validates :description, length: {minimum: 25}
  validates :total_gross, numericality: {
    greater_than_or_equal_to: 0
  }
  validates :image_file_name, format: {
    with: /\w+\.(png|jpg)\z/i,
    message: 'must be a PNG or JPG'
  } 
  validates :rating, inclusion: {in: RATINGS}


  def self.released
    where("released_on <= ?", Time.now).order("released_on desc")
  end

  def flop?
    total_gross <= 250_000_000
  end

  def average_stars
    if reviews.size > 0
      reviews.average(:stars).to_s
    else
      "0.0"
    end
  end

  def average_stars_percent
    if reviews.size > 0
      (reviews.average(:stars) * 100) / Review::STARS.size
    else
      0
    end
  end
end
