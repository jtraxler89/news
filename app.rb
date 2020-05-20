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
  weather_key = "85447264bca3b78435c8f1464453bb70" # replace this with your real OpenWeather API key

  # construct the URL to get the API data (https://openweathermap.org/api/one-call-api)
  url = "https://api.openweathermap.org/data/2.5/onecall?lat=#{lat}&lon=#{long}&units=#{units}&appid=#{weather_key}"

  # make the call
  @forecast = HTTParty.get(url).parsed_response.to_hash

  @current_forecast = "#{@forecast["current"]["temp"].round()} degrees and #{@forecast["current"]["weather"][0]["description"]}"

  @current_time = @forecast["current"]["dt"]

  ### Get the news

  news_key = "18e0406194604b638f36e52c202651d2"
  
  url = "https://newsapi.org/v2/top-headlines?country=us&apiKey=#{news_key}"
  
  @news = HTTParty.get(url).parsed_response.to_hash
  # news is now a Hash you can pretty print (pp) and parse for your output
  
  view "news"

end

