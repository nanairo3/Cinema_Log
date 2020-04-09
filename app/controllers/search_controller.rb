# frozen_string_literal: true

class SearchController < ApplicationController
  require 'faraday'
  require 'json'

  API_KEY = Rails.application.credentials.api_key
  LANGUAGE = 'ja-JP'
  PAGE = 1
  REGION = 'JP'
  CONNECTION = Faraday.new('https://api.themoviedb.org/3/search/movie')

  def index; end

  def search
    if params[:keyword].present?
      movies = get_search_movie_json(params[:keyword])
      # @movies = []
      search_result_id = []
      # note:検索結果を全てDBに保存しており、効率が悪い
      # note:showで表示したものだけを保存したほうが良いのかも
      movies.each do |movie|
        MoviesAcquisitionApiSercvice.get_movie_save(movie)
        search_result_id.push(movie['id'])
      end
      # note:もっと綺麗な書き方がありそう。。。
      @movies = Movie.where(id: search_result_id).where.not(poster_path: '')
      render action: :index
    else
      flash['alert'] = '検索ワードを入力してください'
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
    result = if response.success?
               JSON.parse(response.body)['results']
             else
               []
             end

    result.flatten
  end
end
