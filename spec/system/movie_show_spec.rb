require 'rails_helper'

describe '映画ホームページ', type: :system do
  let!(:example_movie) { create(:movie, poster_path: '/udDclJoHjfjb8Ekgsd4FDteOkCU.jpg') }
  
  before do
    visit movie_path(example_movie)
  end
  
  describe '正常系' do
    it '映画詳細画面の表示情報が正しい' do
      expect(page).to have_content example_movie.title
      expect(page).to have_content example_movie.original_title
      expect(page).to have_content example_movie.release_date
      expect(page).to have_content example_movie.overview
    end
  end
end