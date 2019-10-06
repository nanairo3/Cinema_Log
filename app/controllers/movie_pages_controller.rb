class MoviePagesController < ApplicationController
  def home
    @movies = Movie.all.order(popularity: "DESC").page(params[:page]).per(12)
  end
  
  def show
    @movie = Movie.find(params[:id])
  end
end
