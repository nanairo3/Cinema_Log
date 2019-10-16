require 'rails_helper'

describe '映画情報取得API' do
  describe '.api_execution' do
    let!(:exist_movie) { create :movie, id: 111111 }
    
    before do
      allow(GetMovies).to receive(:get_movie_json) do |get_mode|
        if get_mode == 'now_playing'
          [{
            "id" => 111111,
            "title" =>"now_playing",
            "original_title" => "now_playing",
            "poster_path" => "poster_path",
            "popularity" => 1,
            "release_date" => "release_date",
            "overview" => "overview",
            "video_key" => "video_key"
          }]
        elsif get_mode == 'upcoming'
          [{
            "id" => 222222,
            "title" =>"upcoming",
            "original_title" => "upcoming",
            "poster_path" => "poster_path",
            "popularity" => 1,
            "release_date" => "release_date",
            "overview" => "overview",
            "video_key" => "video_key"
          }]
        end
      end
      expect(Movie.count).to eq 1
    end
    
    it '映画数が全体で2件となっていること' do
      GetMovies.api_execution
      expect(Movie.count).to eq 2
    end

    it 'APIで追加したデータが、正しく保存されていること' do
      GetMovies.api_execution
      expect(Movie.find(111111).title).to eq 'now_playing'
      expect(Movie.find(222222).title).to eq 'upcoming'
    end

    it '既存の映画レコードが更新されていること' do
      old = Movie.find(111111)
      GetMovies.api_execution
      new = Movie.find(111111)
      expect(new.title).not_to eq old.title
    end
    
  end
end