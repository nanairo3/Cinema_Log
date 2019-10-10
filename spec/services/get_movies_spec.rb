require 'rails_helper'

describe '映画情報取得API' do
  describe '正常系' do
    before do
      get_movie_mock = double('Get Movie')
      expect(get_movie_mock).to receive(:get_movie_json, :get_movie_save)
      
      get_movie = GetMovies
      allow(get_movie).to receive(:get_movie_json, :get_movie_save).and_return(get_movie_mock)
    end
    
    content 'get_movie_saveにjsonを渡した場合'do
      it ''
    end
  end
end