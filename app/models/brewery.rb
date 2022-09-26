class Brewery < ApplicationRecord
  include RatingAverage
  has_many :beers, dependent: :destroy
  has_many :ratings, through: :beers

  validates :name, length: { minimum: 1 }

  validates :year, numericality: { greater_than_or_equal_to: 1040,
                                   less_than_or_equal_to: ->(_) { Time.now.year },
                                   only_integer: true }

  scope :active, -> { where active: true }
  scope :retired, -> { where active: [nil, false] }

  def self.top(n)
    Brewery.all.sort_by{ |b| b.ratings.count == 0 ? 0 : 
      b.ratings.inject(0){ |sum, rating| sum+rating.score} / b.ratings.count }
      .reverse
      .take(n)
  end


  def to_s
    name.to_s
  end
end
