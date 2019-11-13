# frozen_string_literal: true

require 'rails_helper'

describe '映画情報取得API' do
  describe '.api_execution' do
    let!(:exist_movie) { create :movie, id: 111_111 }

    before do
      allow(MoviesAcquisitionApiSercvice).to receive(:get_movie_json) do |get_mode|
        if get_mode == 'now_playing'
          [{
            'id' => 111_111,
            'title' => 'now_playing',
            'original_title' => 'now_playing',
            'poster_path' => '1poster_path',
            'popularity' => 1,
            'release_date' => '1release_date',
            'overview' => '1overview'
          }]
        elsif get_mode == 'upcoming'
          [{
            'id' => 222_222,
            'title' => 'upcoming',
            'original_title' => 'upcoming',
            'poster_path' => '2poster_path',
            'popularity' => 1,
            'release_date' => '2release_date',
            'overview' => '2overview'
          }]
        end
      end
      expect(Movie.count).to eq 1
      MoviesAcquisitionApiSercvice.import
    end

    it '映画数が全体で2件となっていること' do
      expect(Movie.count).to eq 2
    end

    it 'APIで追加したデータが、正しく保存されていること' do
      add_movie = Movie.find(222_222)
      expect(add_movie.title).to eq 'upcoming'
      expect(add_movie.original_title).to eq 'upcoming'
      expect(add_movie.poster_path).to eq '2poster_path'
      expect(add_movie.popularity).to eq 1
      expect(add_movie.release_date).to eq '2release_date'
      expect(add_movie.overview).to eq '2overview'
    end

    it '既存の映画レコードが更新されていること' do
      update_movie = Movie.find(111_111)
      expect(update_movie.title).to eq 'now_playing'
      expect(update_movie.original_title).to eq 'now_playing'
      expect(update_movie.poster_path).to eq '1poster_path'
      expect(update_movie.popularity).to eq 1
      expect(update_movie.release_date).to eq '1release_date'
      expect(update_movie.overview).to eq '1overview'
    end
  end
end
