class Genre < ApplicationRecord
  has_many :movie_genres, foreign_key: 'genre_id'
  has_many :movies, through: :movie_genres
end
