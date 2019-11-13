require 'rails_helper'

describe 'いいね機能', type: :system do
  let!(:user) { create(:user) }
  let!(:movie) { create(:movie) }
  let!(:post) { create(:post, movie: movie) }

  before do
    sign_in_as user
  end
  
  describe '正常系' do
    describe '映画詳細画面' do
      before do
        visit movie_path(movie)
      end
      
      context 'いいねをクリックした場合', js: true do
        it 'いいねできる' do
          find('.far').click
          expect(page).to have_css '.fas'
          expect(page).to have_css "div#like-post-#{post.id}", text: '1'
        end
      end
      
      context 'いいねを削除した場合', js: true do
        it 'いいねを取り消せる' do
          find('.far').click
          find('.fas').click
          expect(page).to have_css '.far'
          expect(page).to have_css "div#like-post-#{post.id}", text: '0'
        end
      end
    end
  end
end