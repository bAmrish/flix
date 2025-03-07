class Review < ApplicationRecord
  belongs_to :movie
  
  STARS = [1, 2, 3, 4, 5]
  
  validates :name, presence: true
  validates :stars, inclusion: {
    in: STARS,
    message: "must be between 1 and #{STARS.size}'"
  }
  validates :comment, length: {minimum: 25}


  def stars_as_percent
    (stars * 100.0)/STARS.size
  end
end
