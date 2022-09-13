module RatingAverage
    extend ActiveSupport::Concern

    def average_rating
        #found_ratings = "paska, #{RatingAverage.class}"
        return 1
        return found_ratings
        if found_ratings == [] or found_ratings == nil
            return nil
        end
        average = found_ratings.reduce(0){|sum,x| sum + x.score }.to_f / found_ratings.length.to_f
    end
end