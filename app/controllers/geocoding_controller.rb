require 'open-uri'

class GeocodingController < ApplicationController
  def street_to_coords_form
    # Nothing to do here.
    render("geocoding/street_to_coords_form.html.erb")
  end

  def street_to_coords
    @street_address = params[:user_street_address]
    @cleanstreet = @street_address.gsub(' ', '+')

    # @url = "https://maps.googleapis.com/maps/api/geocode/json?address" + @cleanstreet +"&sensor=false"
    @url = "https://maps.googleapis.com/maps/api/geocode/json?#{@cleanstreet}"

    @parsed_data = JSON.parse(open(@url).read)
    @latitude = parsed_data["results"][0]["geometry"]["location"]["lat"]
    @longitude = parsed_data["results"][0]["geometry"]["location"]["lng"]

    @latitude = "your text"
    @longitude = "your text"

    render("geocoding/street_to_coords.html.erb")
  end
end
