require 'open-uri'

class ForecastController < ApplicationController
  def coords_to_weather_form
    # Nothing to do here.
    render("forecast/coords_to_weather_form.html.erb")
  end

  def coords_to_weather
    @lat = params[:user_latitude]
    @lng = params[:user_longitude]

    url = "https://api.darksky.net/forecast/b50af946be71a06535b4869e2624663e/" << @lat << "," << @lng

    @parsed_data = JSON.parse(open(url).read)
    @current_temperature = @parsed_data["currently"]["temperature"]
    @current_summary = @parsed_data["currently"]["summary"]
    @summary_of_next_sixty_minutes = @parsed_data["minutely"]["summary"]
    @summary_of_next_several_hours = @parsed_data["hourly"]["summary"]
    @summary_of_next_several_days = @parsed_data["daily"]["summary"]

    render("forecast/coords_to_weather.html.erb")
  end
end
