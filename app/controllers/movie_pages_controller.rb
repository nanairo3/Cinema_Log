class MoviePagesController < ApplicationController
  def home
    @movies = Movie.all.order(popularity: "DESC")
  end
  
  def show
    @movie = Movie.find(params[:id])
  end
end
