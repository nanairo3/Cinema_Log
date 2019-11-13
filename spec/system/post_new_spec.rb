# frozen_string_literal: true

require 'rails_helper'

describe '新規投稿', type: :system do
  let!(:user) { create(:user) }
  let!(:movie) { create(:movie) }

  before do
    sign_in_as user
    visit new_movie_post_path(movie)
  end

  describe '正常系' do
    context '正しくcontentを入力した場合' do
      it '投稿できる' do
        fill_in 'post_content', with: 'test'
        click_button '投稿'
        expect(page).to have_content '投稿を作成しました'
      end
    end
  end

  describe '異常系' do
    context 'contentが未入力の場合' do
      it '投稿できない' do
        fill_in 'post_content', with: ' '
        click_button '投稿'
        expect(page).to  have_content 'Contentを入力してください'
      end
    end

    context 'contentが500文字以上の場合' do
      it '投稿できない' do
        fill_in 'post_content', with: 'a'*501
        click_button '投稿'
        expect(page).to have_content 'Contentは500文字以内で入力してください'
      end
    end

    context 'ログアウトした後に新規投稿画面に訪れた場合' do
      it 'ログイン画面に遷移する' do
        click_link 'Logout'
        visit new_movie_post_path(movie)
        expect(current_path).to eq new_user_session_path
      end
    end
  end
end
