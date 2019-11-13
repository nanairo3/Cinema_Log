# frozen_string_literal: true

require 'rails_helper'

describe 'ユーザ新規登録', type: :system do
  let!(:test_user) { create(:user) }

  before do
    visit new_user_registration_path
  end

  describe '正常系' do
    context '正しくname,email,passwordを入力した場合' do
      it '正常にアカウント作成ができる' do
        fill_in '名前', with: 'Test000'
        fill_in 'メールアドレス', with: 'text000@example.com'
        fill_in 'パスワード', with: 'password'
        fill_in '確認', with: 'password'
        click_button 'Sign up'
        expect(page).to have_content 'アカウント登録が完了しました'
      end
    end
  end

  describe '異常系' do
    context '全て未入力の場合' do
      it 'アカウント作成ができない' do
        fill_in '名前', with: ''
        fill_in 'メールアドレス', with: ''
        fill_in 'パスワード', with: ''
        fill_in '確認', with: ''
        click_button 'Sign up'
        expect(page).to have_content '保存されませんでした'
      end
    end
    
    context 'passwordが６文字未満の場合' do
      it 'アカウント作成ができない' do
        fill_in '名前', with: ''
        fill_in 'メールアドレス', with: ''
        fill_in 'パスワード', with: '12345'
        fill_in '確認', with: '12345'
        click_button 'Sign up'
        expect(page).to have_content 'パスワードは6文字以上で入力してください'
      end
    end
    
    context 'passwordとpassword_confirmationが異なる場合' do
      it 'アカウント作成ができない' do
        fill_in '名前', with: ''
        fill_in 'メールアドレス', with: ''
        fill_in 'パスワード', with: 'aaaaaa'
        fill_in '確認', with: 'bbbbbb'
        click_button 'Sign up'
        expect(page).to have_content 'パスワード（確認用）とパスワードの入力が一致しません'
      end
    end
  end
end