class Beer < ApplicationRecord
  include RatingAverage
  belongs_to :brewery
  has_many :ratings, dependent: :destroy
  has_many :raters, through: :ratings, source: :user

  validates :name, length: { minimum: 1 }
  validates :style_id, length: { minimum: 1 }

  def average
    return 0 if ratings.empty?

    ratings.map(&:score).sum / ratings.count.to_f
  end

  def self.top(n)
    Beer.all.sort_by(&:average)
        .reverse
        .take(n)
  end

  def to_s
    "#{name}, #{Brewery.find_by id: brewery_id} "
  end
end
