require "sinatra"
require "sinatra/reloader"
require "httparty"
def view(template); erb template.to_sym; end

get "/" do
  ### Get the weather
  # Evanston, Kellogg Global Hub... replace with a different location if you want
  lat = 42.0574063
  long = -87.6722787

  units = "imperial" # or metric, whatever you like
  key = "85447264bca3b78435c8f1464453bb70" # replace this with your real OpenWeather API key

  # construct the URL to get the API data (https://openweathermap.org/api/one-call-api)
  url = "https://api.openweathermap.org/data/2.5/onecall?lat=#{lat}&lon=#{long}&units=#{units}&appid=#{key}"

  # make the call
  @forecast = HTTParty.get(url).parsed_response.to_hash

  puts "The weather at your requested location is #{forecast["current"]["temp"]} degrees and #{forecast["current"]["weather"][0]["main"]}"
  puts"Extended forecast:"
  for day in forecast["daily"]
    puts "A high of #{day["temp"]["max"]} and #{day["weather"][0]["main"]}"
  end
  
  puts "My name is Jeff!"

  ### Get the news
end
