# frozen_string_literal: true

class Genre < ApplicationRecord
  has_many :movie_genres, foreign_key: 'genre_id', dependent: :destroy
  has_many :movies, through: :movie_genres
end
