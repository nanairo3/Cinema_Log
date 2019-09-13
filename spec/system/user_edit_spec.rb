require 'rails_helper'

describe 'ユーザ編集機能', type: :system do
  let!(:user) { create(:user) }

  before do
    sign_in_as user
    visit edit_user_registration_path
  end

  context '編集成功したとき' do
    it '編集成功' do
      fill_in 'user_name', with: 'Taro'
      fill_in 'user_email', with: 'taro@example.com'
      fill_in 'user_current_password', with: 'apassword'
      fill_in 'user_password', with: 'taropassword'
      fill_in 'user_password_confirmation', with: 'taropassword'
      click_button '更新'
      expect(page).to have_content 'アカウント情報を変更しました'
    end
  end

  context '編集失敗' do
    it 'name未入力' do
      fill_in 'user_name', with: ''
      click_button '更新'
      expect(page).to have_content 'Nameを入力してください'
    end

    it 'email未入力' do
      fill_in 'user_email', with: ''
      click_button '更新'
      expect(page).to have_content 'Eメールを入力してください'
    end

    it '現在のパスワードが間違っているとき' do
      fill_in 'user_current_password', with: '間違いpassword'
      fill_in 'user_password', with: 'taropassword'
      fill_in 'user_password_confirmation', with: 'taropassword'
      click_button '更新'
      expect(page).to have_content '現在のパスワードは不正な値です'
    end

    it '新しいパスワードと確認が間違っているとき' do
      fill_in 'user_current_password', with: 'apassword'
      fill_in 'user_password', with: 'taropassword'
      fill_in 'user_password_confirmation', with: '間違いpassword'
      click_button '更新'
      expect(page).to have_content 'パスワード（確認用）とパスワードの入力が一致しません'
    end

    it '新しいパスワードが6文字未満の時' do
      fill_in 'user_current_password', with: 'apassword'
      fill_in 'user_password', with: '12345'
      fill_in 'user_password_confirmation', with: '12345'
      click_button '更新'
      expect(page).to have_content 'パスワードは6文字以上で入力してください'
    end
  end
end