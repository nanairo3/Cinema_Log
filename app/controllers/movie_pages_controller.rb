class MoviePagesController < ApplicationController
  def home
    @movies = Movie.all.order(popularity: "DESC").page(params[:page])
  end
  
  def show
    @movie = Movie.find(params[:id])
  end
end
