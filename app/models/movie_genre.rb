# frozen_string_literal: true

class MovieGenre < ApplicationRecord
  belongs_to :movie
  belongs_to :genre
end
