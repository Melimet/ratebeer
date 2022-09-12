class Beer < ApplicationRecord
    belongs_to :brewery
    has_many :ratings

    def average_rating
        found_ratings = Rating.where beer_id: self.id
        if found_ratings == [] or found_ratings == nil
            return  "This beer has no ratings yet!"
        end
        average = found_ratings.reduce(0){|sum,x| sum + x.score }.to_f / found_ratings.length.to_f
        
        
        "This beer has "+ found_ratings.length.to_s + " rating".pluralize(found_ratings.length) +" with a rating of "+ average.to_s
        
    end

    def to_s
        "#{self.name}, #{Brewery.find_by id: self.brewery_id} "
    end
    
end
