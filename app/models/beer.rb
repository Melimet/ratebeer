class Beer < ApplicationRecord
  include RatingAverage
  belongs_to :brewery
  has_many :ratings, dependent: :destroy

  validates :name, length: { minimum: 1}
  
  def average
    return 0 if ratings.empty?

    ratings.map(&:score).sum / ratings.count.to_f
  end

  def to_s
    "#{name}, #{Brewery.find_by id: brewery_id} "
  end
end
