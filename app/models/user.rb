require 'digest'
class User < ApplicationRecord
  has_secure_password
  BASE_GRAVATAR_IMAGE = 'https://gravatar.com/avatar'

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
