class SearchController < ApplicationController
  require 'faraday'
  require 'json'

  API_KEY = Rails.application.credentials.api_key
  LANGUAGE = 'ja-JP'
  PAGE = 1
  REGION = 'JP'
  CONNECTION = Faraday.new('https://api.themoviedb.org/3/search/movie')

  def index
  end

  def search
    if params[:keyword]
      movies = get_search_movie_json(params[:keyword])
      @movies = []
      if movies.present?
        movies.each do |movie|
          movie_data = Movie_data.new(
            movie["title"],
            movie["poster_path"],
            movie["popularity"],
            movie["release_date"],
            movie["overview"],
            movie["video_key"],
            movie["run_time"]
          )
          @movies << movie_data
        end
        render action: :index
      else
        flash[:alert] = "検索結果がありませんでした"
        redirect_to root_path
      end
    else
      flash["alert"] = "検索ワードを入力してください"
      redirect_to root_path
    end
  end

  private

    def get_search_movie_json(keyword)
      response = CONNECTION.get do |request|
        request.params[:api_key] = API_KEY
        request.params[:language] = LANGUAGE
        request.params[:query] = keyword
        request.params[:page] = PAGE
        request.params[:include_adult] = false
      end
      if response.success?
        result = JSON.parse(response.body)['results']
      else
        result = []
      end
      
      result.flatten
    end

    class Movie_data
      attr_accessor :title, :poster_path, :popularity, :release_date,
        :overview, :video_key, :run_time
      def initialize(title, poster_path, popularity, release_date, overview, video_key, run_time)
        @title = title
        @poster_path = poster_path
        @popularity = popularity
        @release_date = release_date
        @overview = overview
        @video_key = video_key
        @run_time = run_time
      end
    end
end
