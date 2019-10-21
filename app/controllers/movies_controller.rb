class MoviesController < ApplicationController
  def index
    @movies = Movie.where.not(poster_path: '').order(popularity: "DESC").page(params[:page]).per(12)
  end

  def show
    @movie = Movie.find(params[:id])
    @posts = Post.where(movie_id: params[:id])
  end
end
