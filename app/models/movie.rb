class Movie < ApplicationRecord
  before_save :set_slug

  has_many :reviews, -> {order(created_at: :desc)}, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :fans, through: :favorites, source: :user
  has_many :critics, through: :reviews, source: :user
  has_many :movie_genres, dependent: :destroy
  has_many :genres, through: :movie_genres

  has_one_attached :poster_image
  
  RATINGS = %w"G PG PG-13 R NC-17"
  validates :title, presence: true, uniqueness: { case_sensitive: false }
  validates :released_on, presence: true
  validates :duration, presence: true
  validates :description, length: { minimum: 25 }

  validates :total_gross, numericality: {
    greater_than_or_equal_to: 0
  }

  validates :rating, inclusion: {in: RATINGS}

  validate :acceptable_image
  
  scope :released, -> { where("released_on <= ?", Time.now).order("released_on desc") }
  scope :upcoming, -> { where("released_on >= ?", Time.now).order("released_on asc") }
  scope :recent, -> (max = 5) { released.limit(max) }
  scope :hits, -> { released.where("total_gross > ?", 250_000_000).order(total_gross: :desc) }
  scope :flops, -> { released.where("total_gross <= ?", 250_000_000).order(total_gross: :asc) }

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
  
  def to_param
    slug
  end

private
  def set_slug
    self.slug = title.parameterize
  end

  def acceptable_image
    return unless poster_image.attached?

    unless poster_image.blob.byte_size <= 1.megabytes
      errors.add(:poster_image, 'Is too big. It should be less than 1 MB.')
    end
    acceptable_types = ['image/png', 'image/jpeg']
    unless acceptable_types.include?(poster_image.content_type)
      errors.add(:poster_image, 'Invalid type. Image must be PNG or JPEG.')
    end
  end
end
