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
    @places = BeermappingApi.places_in(city)
    if @places.empty?
      redirect_to places_path, notice: "No locations in #{params[:city]}"
    else
      session[:last_search] = ERB::Util.url_encode(city)
      render :index, status: 418
    end
  end

  def to_s
    @place
  end
end
