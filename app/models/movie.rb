class Movie < ApplicationRecord

  has_many :reviews, dependent: :destroy

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
end
