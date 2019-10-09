require 'faraday'
require 'json'

class GetMovies
  
  def self.now_playing_json(connection, api_key, language, page, region)
    response = connection.get "/3/movie/now_playing" do |request|
     request.params[:api_key] =  api_key
     request.params[:language] = language
     request.params[:page] = page
     request.params[:region] = region
    end
    
    count = JSON.parse(response.body)['total_pages']
    result = []
    
    count.times do |timecount|
      response = connection.get "/3/movie/now_playing" do |request|
       request.params[:api_key] =  api_key
       request.params[:language] = language
       request.params[:page] = timecount + 1
       request.params[:region] = region
      end
      
      if response.success?
        result.push(JSON.parse(response.body)['results'])
      else
        puts "通信エラー: #{response.status}"
      end
    end
    return result.flatten
  end
  
  def self.now_playing_save(json)
    if Movie.find_by_id(json['id']).nil? && json['poster_path']
      Movie.create(id: json['id'], title: json['title'], original_title: json['original_title'],
                     poster_path: json['poster_path'], popularity: json['popularity'], release_date: json['release_date'],
                     overview: json['overview'])
                     
        json['genre_ids'].each do |genre|
          MovieGenre.create(movie_id: json['id'], genre_id: genre)
      end
    end
  end
  
  def self.interface
    api_key = Rails.application.credentials.api_key
    language = "ja-JP"
    page = 1
    region = "JP"
    connection = Faraday.new("https://api.themoviedb.org") 
    
    json = now_playing_json(connection, api_key, language, page, region)
    json.each do |json|
      now_playing_save(json)
    end
  end
    
end