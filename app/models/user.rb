class User < ApplicationRecord
  has_secure_password

  validates :name, presence: true
  validates :email, format: { with: /\S+@\S+/},
            uniqueness: {case_sensitive: false}
  validates :password, length: {minimum: 10, allow_blanks: true}

end
