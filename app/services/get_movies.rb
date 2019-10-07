require 'faraday'
require 'json'

class GetMovies
  def initialize
    api_key = Rails.application.credentials.api_key
    language = "ja-JP"
    page = 1
    region = "JP"
    now_playing = ["start set"]
    up_coming = ["start set"]
    
    #ENV["SSL_CERT_PATH"] = "/etc/pki/tls"
    connection = Faraday.new("https://api.themoviedb.org") 
    
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
                         
            now['genre_ids'].each do |now_genre|
              MovieGenre.create(movie_id: now['id'], genre_id: now_genre)
            end
          end
        end
      else
        puts "通信エラー: #{response.status}"
      end
      
      page += 1
    end
    
    page = 1
    
    while up_coming != []
       response = connection.get "/3/movie/upcoming" do |request|
         request.params[:api_key] =  api_key
         request.params[:language] = language
         request.params[:page] = page
         request.params[:region] = region
        end
      
      if response.success?
        up_coming = JSON.parse(response.body)['results']
        up_coming.each do |up|
          if Movie.find_by_id(up['id']).nil? && up['poster_path']
            Movie.create(id: up['id'], title: up['title'], original_title: up['original_title'],
                       poster_path: up['poster_path'], popularity: up['popularity'], release_date: up['release_date'],
                       overview: up['overview'])
                       
            up['genre_ids'].each do |up_genre|
              MovieGenre.create(movie_id: up['id'], genre_id: up_genre)
            end
          end
        end
      else
        puts "通信エラー: #{response.status}"
      end
      
      page += 1
    end
    
    
    movies = Movie.all
    movies.each do |movie|
      response = connection.get "/3/movie/#{movie.id}" do |request|
        request.params[:api_key] =  api_key
        request.params[:language] = language
      end
      
      if response.success?
        detail = JSON.parse(response.body)
        if movie.run_time.nil?
          movie.run_time = detail['runtime']
          movie.save
        end
      else
        puts "通信エラー: #{response.status}"
      end
    
      response = connection.get "/3/movie/#{movie.id}/videos" do |request|
        request.params[:api_key] =  api_key
      end
      if response.success?
        video = JSON.parse(response.body)['results']
        if movie.video_key.nil? && video != []
          movie.video_key = video[0]['key']
          movie.save
        end
      else
        puts "通信エラー: #{response.status}"
      end
      
    end
  end
end