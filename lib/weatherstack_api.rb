class WeatherstackApi
  def self.get_weather_in(city)
    url = "http://api.weatherstack.com/current?access_key=#{key}&query=#{ERB::Util.url_encode(city)}"

    response = HTTParty.get url

    response.parsed_response["current"]
  end

  def self.key
    return nil if Rails.env.test?
    raise 'WEATHERSTACK_APIKEY env variable not defined' if ENV['WEATHERSTACK_APIKEY'].nil?

    ENV.fetch('WEATHERSTACK_APIKEY')
  end
end
