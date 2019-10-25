class Movie < ApplicationRecord
  has_many :movie_genres, foreign_key: 'movie_id'
  has_many :genres, through: :movie_genres
  
  has_many :posts, dependent: :destroy
end
