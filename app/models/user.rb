class User < ApplicationRecord
  include RatingAverage
  has_secure_password
  has_many :ratings
  has_many :beers, through: :ratings
  has_many :memberships
  has_many :beer_clubs, through: :memberships

  validates :username, uniqueness: true,
                       length: { minimum: 3, maximum: 30 }

  validates :password, length: { minimum: 4 },
    format: { with: /\A[A-Z].*\d|\d.*[A-Z]\z/, message: "Password must contain atleast 1 upper case letter and a numeral" }

  has_many :ratings

  def to_s
    username.to_s
  end
end
