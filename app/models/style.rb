class Style < ApplicationRecord
  has_many :beers

  def self.top(n)
    Style.all.sort_by{|s| s.beers.inject(0){ |sum, b|sum + b.average}}
    .reverse
    .take(n)
  end

  def average
    (beers.inject(0){|sum, b|sum + b.average} / beers.count).round(1)
  end

  def to_s
    name
  end
end
