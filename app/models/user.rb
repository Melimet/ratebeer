class User < ApplicationRecord
  include RatingAverage

  has_secure_password

  has_many :ratings, dependent: :destroy
  has_many :beers, through: :ratings

  has_many :memberships
  has_many :beer_clubs, through: :memberships

  validates :username, uniqueness: true,
                       length: { minimum: 3, maximum: 30 }

  validates :password, length: { minimum: 4 },
                       format: { with: /\A[A-Z].*\d|\d.*[A-Z]\z/, message: "Password must contain atleast 1 upper case letter and a numeral" }

  def favorite_beer
    return nil if ratings.empty?

    ratings.max_by(&:score).beer
  end

  def favorite_style
    return nil if beers.empty?

    style_ratings = Hash.new { |hash, key| hash[key] = [] }

    ratings.map { |rating|
      beer = Beer.find_by id: rating.beer_id
      style_ratings[beer.style_id] << rating.score
    }

    favourite_style_id = style_ratings.max_by { |_style_id, list| list.sum / list.length }[0]
    (Style.find_by id: favourite_style_id).to_s
  end

  def favorite_brewery
    return nil if beers.empty?

    breweries_by_ratings = Hash.new { |hash, key| hash[key] = [] }

    ratings.map { |rating|
      beer = Beer.find_by id: rating.beer_id
      brewery = Brewery.find_by id: beer.brewery_id
      breweries_by_ratings[brewery.name].push(rating.score)
    }

    breweries_by_ratings.max_by { |_brewery, list| list.sum / list.length }[0]
  end

  def self.top(n)
    User.all.sort_by{ |user| user.ratings.count }.reverse.take(n)
  end

  def to_s
    username.to_s
  end
end
