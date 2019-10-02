require 'faraday'
require 'json'

class GetMovies
  def initialize
    api_key = Rails.application.credentials.api_key
    language = "ja-JP"
    page = 1
    region = "JP"
    now_playing = ["start set"]
    
    #ENV["SSL_CERT_PATH"] = "/etc/pki/tls"
    connection = Faraday.new("https://api.themoviedb.org") 
    
    while now_playing != []
      response = connection.get "/3/movie/now_playing" do |request|
       request.params[:api_key] =  api_key
       request.params[:language] = language
       request.params[:page] = page
       request.params[:region] = region
      end
      
      if response.success?
        now_playing = JSON.parse(response.body)['results']
        now_playing.each do |now|
          if Movie.find_by_id(now['id']).nil? && now['poster_path']
            Movie.create(id: now['id'], title: now['title'], original_title: now['original_title'],
                         poster_path: now['poster_path'], popularity: now['popularity'], release_date: now['release_date'],
                         overview: now['overview'])
          end
        end
      else
        puts "通信エラー: #{response.status}"
      end
      
      page += 1
    end
    
    response = connection.get "/3/genre/movie/list" do |request|
      request.params[:api_key] =  api_key
      request.params[:language] = language
    end
    genre_json = JSON.parse(response.body)["genres"]
    genre_json.each do |genre|
      if response.success?
        if Genre.find_by_id(genre['id']).nil?
          Genre.create(id: genre['id'], name: genre['name'])
        end
      else
        puts "通信エラー: #{response.status}"
      end
    end
    
    
    movies = Movie.all
    movies.each do |movie|
      response = connection.get "/3/movie/#{movie.id}" do |request|
        request.params[:api_key] =  api_key
        request.params[:language] = language
        request.params[:append_to_response] = "videos"
      end
      
      if response.success?
        detail = JSON.parse(response.body)
        puts detail['videos']['results']
        if movie.run_time.nil? || movie.video_key.nil?
          movie.run_time = detail['runtime']
          movie.video_key = detail['videos']['results']["key"] if detail['videos']['results'] != []
          movie.save
        end
      else
        puts "通信エラー: #{response.status}"
      end
    end
  end

end