require 'digest'
class User < ApplicationRecord
  has_secure_password
  
  has_many :reviews, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorite_movies, through: :favorites, source: :movie
  
  scope :by_name, -> {order(name: :asc)}
  scope :non_admins, -> {by_name.where(admin: false)}
  scope :admins, -> {by_name.where(admin: true)}

  BASE_GRAVATAR_IMAGE = 'https://gravatar.com/avatar'

  validates :username, 
    presence: true, 
    uniqueness: {
      case_sensitive: false
    }, 
    length: {
      minimum: 4,
      maximum: 20
    },
    format: {
      with: /\A[a-zA-Z0-9\.]+\z/i,
      message: 'should only contains letters, numbers and period'
    }
  validates :name, presence: true
  validates :email, format: { with: /\S+@\S+/},
            uniqueness: {case_sensitive: false}
  validates :password, length: {minimum: 10, allow_blank: true}

  class << self
    attr_accessor :default_image_type
  end

  def profile_image
    default_image_type ='name'

    if default_image_type == 'name'
      profile_image_name
    else
      profile_image_monster
    end
  end

  def profile_image_monster
    default_type = 'monsterid'
    e = email.strip.downcase
    hash = Digest::SHA256.hexdigest(e)
    "#{BASE_GRAVATAR_IMAGE}/#{hash}?d=#{default_type}"
  end

  def profile_image_name
    default_type = 'initials'
    e = email.strip.downcase
    hash = Digest::SHA256.hexdigest(e)
    "#{BASE_GRAVATAR_IMAGE}/#{hash}?d=#{default_type}&name=#{name}"
  end
end
