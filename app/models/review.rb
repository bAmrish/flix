class Review < ApplicationRecord
  belongs_to :movie
  belongs_to :user
  
  STARS = [1, 2, 3, 4, 5]
  
  validates :stars, inclusion: {
    in: STARS,
    message: "must be between 1 and #{STARS.size}"
  }

  validates :comment, length: {minimum: 25}

  scope :recent_reviews, -> (max = 7) { limit(max).order(created_at: :desc) }

  def stars_as_percent
    (stars * 100.0)/STARS.size
  end
end
