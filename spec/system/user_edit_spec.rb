# frozen_string_literal: true

require 'rails_helper'

describe 'ユーザ編集機能', type: :system do
  let!(:user) { create(:user) }

  before do
    sign_in_as user
    visit edit_user_registration_path
  end

  describe '正常系' do
    context '正しいimage,name,email,current_password.passwordを入力した場合' do
      it '正常にアカウント情報を変更される' do
        file_path = Rails.root.join('spec', 'images', 'test_sample.png')
        attach_file 'user_image', file_path
        fill_in 'user_name', with: 'Taro'
        fill_in 'user_email', with: 'taro@example.com'
        fill_in 'user_current_password', with: user.password
        fill_in 'user_password', with: 'taropassword'
        fill_in 'user_password_confirmation', with: 'taropassword'
        click_button '更新'
        expect(page).to have_content 'アカウント情報を変更しました'
      end
    end
  end

  describe '異常系' do
    context 'name未入力の場合' do
      it 'アカウント情報を変更できない' do
        fill_in 'user_name', with: ''
        click_button '更新'
        expect(page).to have_content 'Nameを入力してください'
      end

      context 'email未入力の場合' do
        it 'アカウント情報を変更できない' do
          fill_in 'user_email', with: ''
          click_button '更新'
          expect(page).to have_content 'Eメールを入力してください'
        end
      end

      context '現在のパスワードが間違っている場合'
      it 'アカウント情報を変更できない' do
        fill_in 'user_current_password', with: '間違いpassword'
        fill_in 'user_password', with: 'taropassword'
        fill_in 'user_password_confirmation', with: 'taropassword'
        click_button '更新'
        expect(page).to have_content '現在のパスワードは不正な値です'
      end
    end

    context '新しいパスワードと確認が間違っている場合' do
      it 'アカウント情報を変更できない' do
        fill_in 'user_current_password', with: 'apassword'
        fill_in 'user_password', with: 'taropassword'
        fill_in 'user_password_confirmation', with: '間違いpassword'
        click_button '更新'
        expect(page).to have_content 'パスワード（確認用）とパスワードの入力が一致しません'
      end
    end

    context '新しいパスワードが6文字未満の場合' do
      it 'アカウント情報を変更できない' do
        fill_in 'user_current_password', with: 'apassword'
        fill_in 'user_password', with: '12345'
        fill_in 'user_password_confirmation', with: '12345'
        click_button '更新'
        expect(page).to have_content 'パスワードは6文字以上で入力してください'
      end
    end
  end
end
