require 'faraday'
require 'json'

class GetMovies
  API_KEY = Rails.application.credentials.api_key
  LANGUAGE = "ja-JP"
  PAGE = 1
  REGION = "JP"
  CONNECTION = Faraday.new("https://api.themoviedb.org") 

  def self.now_playing_json(get_mode)
    response = CONNECTION.get "/3/movie/#{get_mode}" do |request|
     request.params[:api_key] =  API_KEY
     request.params[:language] = LANGUAGE
     request.params[:page] = PAGE
     request.params[:region] = REGION
    end
    
    count = JSON.parse(response.body)['total_pages']
    result = JSON.parse(response.body)['results']
    renge=2..count
    
    renge.each do |page|
      response = CONNECTION.get "/3/movie/#{get_mode}" do |request|
       request.params[:api_key] =  API_KEY
       request.params[:language] = LANGUAGE
       request.params[:page] =  page
       request.params[:region] = REGION
      end
      
      if response.success?
        result.push(JSON.parse(response.body)['results'])
      else
        puts "通信エラー: #{response.status}"
      end
    end
    return result.flatten
  end
  
  def self.now_upcomming_save(json)
    if Movie.find_by_id(json['id']).nil?
      Movie.create(id: json['id'], title: json['title'] || '', original_title: json['original_title'] || '',
                     poster_path: json['poster_path'] || '' , popularity: json['popularity'], release_date: json['release_date'],
                     overview: json['overview'])
                     
        json['genre_ids'].each do |genre_id|
          MovieGenre.create(movie_id: json['id'], genre_id: genre_id)
      end
    else
      Movie.find_by_id(json['id']).update(:title => json['title'] || '', :original_title => json['original_title'] || '',
                                              :poster_path => json['poster_path'] || '', :popularity => json['popularity'],
                                              :release_date => json['release_date'], :overview => json['overview'])
    end
  end
  
  def self.interface
    json = now_playing_json("now_playing")
    json += now_playing_json("upcoming")
    json.each do |json|
      now_upcomming_save(json)
    end
  end
    
end