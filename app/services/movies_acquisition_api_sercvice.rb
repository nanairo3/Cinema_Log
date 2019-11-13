# frozen_string_literal: true

require 'faraday'
require 'json'

class MoviesAcquisitionApiSercvice
  API_KEY = Rails.application.credentials.api_key
  LANGUAGE = 'ja-JP'
  PAGE = 1
  REGION = 'JP'
  CONNECTION = Faraday.new('https://api.themoviedb.org')

  class << self
    def import
      json = get_movie_json('now_playing')
      json += get_movie_json('upcoming')
      json.each do |json|
        get_movie_save(json)
      end
    end

    private

    def get_movie_json(get_mode)
      response = CONNECTION.get "/3/movie/#{get_mode}" do |request|
        request.params[:api_key] = API_KEY
        request.params[:language] = LANGUAGE
        request.params[:page] = PAGE
        request.params[:region] = REGION
      end

      raise "通信エラー： #{response.status}" unless response.success?

      count = JSON.parse(response.body)['total_pages']
      result = JSON.parse(response.body)['results']
      renge = 2..count

      renge.each do |page|
        response = CONNECTION.get "/3/movie/#{get_mode}" do |request|
          request.params[:api_key] = API_KEY
          request.params[:language] = LANGUAGE
          request.params[:page] = page
          request.params[:region] = REGION
        end

        raise "通信エラー: #{response.status}" unless response.success?

        result.push(JSON.parse(response.body)['results'])
      end

      result.flatten
    end

    def get_movie_save(json)
      movie = Movie.find_or_initialize_by(id: json['id'])
      movie.assign_attributes(
        title: json['title'] || '',
        original_title: json['original_title'] || '',
        poster_path: json['poster_path'] || '',
        popularity: json['popularity'],
        release_date: json['release_date'],
        overview: json['overview'],
      )
      movie.save!
    end
  end
end
