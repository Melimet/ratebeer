class PlacesController < ApplicationController
  def index
  end

  def show
    places = Rails.cache.fetch(session[:last_search])

    places.each do |place|
      if place.send("id") == params[:id]
        @place = place
        return @place
      end
    end
    redirect_to places_path, notice: "No such bar!"
  end

  def search
    city = params[:city].downcase
    return if city.empty?

    @places = BeermappingApi.places_in(city)
    if @places.empty?
      redirect_to places_path, notice: "No locations in #{params[:city]}"
    else
      @city = city
      @weather = WeatherstackApi.get_weather_in(city) unless Rails.env.test?
      session[:last_search] = ERB::Util.url_encode(city)
      render :index, status: 418
    end
  end

  def to_s
    @place
  end
end
