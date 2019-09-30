require 'faraday'
require 'json'

api_key = Rails.application.credentials.api_key
language = "ja-JP"
page = 1
region = "JP"

connection = Faraday::Connection.new('https://api.themoviedb.org/3/movie')
response = connection.get "/now_playing" do |request|
 request.params[:api_key] =  api_key
 request.params[:language] = language
 request.params[:page] = page
 request.params[:region] = region
end

if response.success?
  now_playing = JSON.perse(response.body['result'])
  now_playing.each do |now|
    if Movie.find(id: now['id']).nil?
      Movie.create(id: now['id'], title: now['title'], original_title: now['original_title'],
                   poster_path: now['poster_path'], popularity: now['popularity'], release_date: now['release_date'],
                   overview: now['overview'])
    end
  end
else
  flash[:alert] = "通信エラー： #{response.status}"
end