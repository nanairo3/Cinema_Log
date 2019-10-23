require 'rails_helper'

describe '投稿編集機能', type: :system do
  let!(:users){ create_list(:user, 2) }
  let!(:post){ create(:post, user: users.first) }
  
  before do
    sign_in_as users.first
    visit edit_post_path(post)
  end
  
  describe '正常系' do
    context '自分の投稿を正しく入力した場合' do
      it '編集できる' do
        fill_in 'post_content', with: 'edit_test'
        click_button '更新する'
        expect(page).to have_content '投稿を更新しました'
      end
    end
  end
    
  describe '異常系' do
    context '自分の投稿を未入力で更新した場合' do
      it '編集できない' do
        fill_in 'post_content', with: ' '
        click_button '更新する'
        expect(page).to  have_content 'Contentを入力してください'
      end
    end
    
    context '自分の投稿を500文字以上で更新した場合' do
      it '編集できない' do
        fill_in 'post_content', with: 'a'*501
        click_button '更新する'
        expect(page).to  have_content 'Contentは500文字以内で入力してください'
      end
    end
    
    context '自分以外の投稿を編集しようとした場合' do
      it '編集できず、rootページに遷移する' do
        click_link 'Logout'
        sign_in_as users[1]
        visit edit_post_path(post)
        expect(current_path).to eq root_path
        expect(page).to have_content '権限がありません'
      end
    end
  end
end