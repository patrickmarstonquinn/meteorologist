require 'open-uri'

class MeteorologistController < ApplicationController
  def street_to_weather_form
    # Nothing to do here.
    render("meteorologist/street_to_weather_form.html.erb")
  end

  def street_to_weather
    @street_address = params[:user_street_address]
    @street = @street_address.gsub(' ', '+')
    url = "https://maps.googleapis.com/maps/api/geocode/json?address=" << @street << "&sensor=false"
    @parsed_data = JSON.parse(open(url).read)
    @latitude = @parsed_data["results"][0]["geometry"]["location"]["lat"].to_s
    @longitude = @parsed_data["results"][0]["geometry"]["location"]["lng"].to_s

    url = "https://api.darksky.net/forecast/b50af946be71a06535b4869e2624663e/" << @latitude << "," << @longitude

    @parsed_data = JSON.parse(open(url).read)
    @current_temperature = @parsed_data["currently"]["temperature"]
    @current_summary = @parsed_data["currently"]["summary"]
    @summary_of_next_sixty_minutes = @parsed_data["minutely"]["summary"]
    @summary_of_next_several_hours = @parsed_data["hourly"]["summary"]
    @summary_of_next_several_days = @parsed_data["daily"]["summary"]

    # @current_temperature = "Replace this string with your answer."
    #
    # @current_summary = "Replace this string with your answer."
    #
    # @summary_of_next_sixty_minutes = "Replace this string with your answer."
    #
    # @summary_of_next_several_hours = "Replace this string with your answer."
    #
    # @summary_of_next_several_days = "Replace this string with your answer."

    render("meteorologist/street_to_weather.html.erb")
  end
end
