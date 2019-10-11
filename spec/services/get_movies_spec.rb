require 'rails_helper'

describe '映画情報取得API' do
  describe '正常系' do
    let!(:json){ create(:movie) }
    
    before do
      allow(GetMovies).to receive(:get_movie_save).and_return('get movie save mock')
    end
    
    context 'get_movie_saveにjsonを渡した場合'do
      it 'エラーなく保存できる' do
        expect{ GetMovies.get_movie_save(json) }.not_to raise_error
      end
    end
    
  end
end