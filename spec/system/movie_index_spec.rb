# frozen_string_literal: true

require 'rails_helper'

describe '映画ホームページ', type: :system do
  let!(:example_movie) { create(:movie, id: 111111, poster_path: '/udDclJoHjfjb8Ekgsd4FDteOkCU.jpg') }
  
  before do
    visit root_path
  end
  
  describe '正常系' do
    context '映画一覧が表示される場合' do
      it '映画一覧が表示される' do
        expect(page).to have_content '注目の映画'
        expect(page).to have_content example_movie.title
      end
    end
    
    context '映画画像をクリックした場合' do
      it '映画詳細画面へ遷移する' do
        click_on 'movie pic'
        expect(current_path).to eq movie_path(example_movie)
        expect(page).to have_content example_movie.title
        expect(page).to have_content example_movie.original_title
        expect(page).to have_content example_movie.release_date
        expect(page).to have_content example_movie.overview
      end
    end
  end
end