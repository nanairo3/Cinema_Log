require 'rails_helper'

describe '映画情報取得API' do
  describe '.api_execution' do
    let!(:exist_movie) { create :movie }
    
    before do
      allow(GetMovies).to receive(:get_movie_json) do |get_mode|
        if get_mode == 'now_playing'
          [{
            "id" => 111111,
            "title" =>"now_playing",
            "original_title" => "now_playing",
            "poster_path" => "1poster_path",
            "popularity" => 1,
            "release_date" => "1release_date",
            "overview" => "1overview"
          }]
        elsif get_mode == 'upcoming'
          [{
            "id" => 222222,
            "title" =>"upcoming",
            "original_title" => "upcoming",
            "poster_path" => "2poster_path",
            "popularity" => 1,
            "release_date" => "2release_date",
            "overview" => "2overview"
          }]
        end
      end
      expect(Movie.count).to eq 1
      GetMovies.api_execution
    end
    
    it '映画数が全体で2件となっていること' do
      expect(Movie.count).to eq 2
    end

    it 'APIで追加したデータが、正しく保存されていること' do
      expect(Movie.find(222222).title).to eq 'upcoming'
      expect(Movie.find(222222).original_title).to eq 'upcoming'
      expect(Movie.find(222222).poster_path).to eq '2poster_path'
      expect(Movie.find(222222).popularity).to eq 1
      expect(Movie.find(222222).release_date).to eq '2release_date'
      expect(Movie.find(222222).overview).to eq '2overview'
    end

    it '既存の映画レコードが更新されていること' do
      expect(Movie.find(111111).title).to eq 'now_playing'
      expect(Movie.find(111111).original_title).to eq 'now_playing'
      expect(Movie.find(111111).poster_path).to eq '1poster_path'
      expect(Movie.find(111111).popularity).to eq 1
      expect(Movie.find(111111).release_date).to eq '1release_date'
      expect(Movie.find(111111).overview).to eq '1overview'
    end
    
  end
end