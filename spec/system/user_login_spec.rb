# frozen_string_literal: true

require 'rails_helper'

describe 'ログイン機能', type: :system do
  let!(:user) { create(:user) }
    let!(:test_user) { create(:user) }

    before do
      visit new_user_session_path
    end

    describe '正常系' do
      context '正しくemail、passwordを入力した場合' do
        it 'ログインできる' do
          fill_in 'session_email', with: user.email
          fill_in 'session_password', with: user.password
          click_button 'Login'
          expect(page).to have_content 'ログインしました。'
        end
      end
    end

    describe '異常系' do
      context '間違ったpasswordを入力した場合' do
        it 'ログインできない' do
          fill_in 'session_email', with: user.email
          fill_in 'session_password', with: 'nonpassword'
          click_button 'Login'
          expect(page).to have_content 'Eメールまたはパスワードが違います。'
        end
      end

        context '未入力の場合' do
          it 'should have_content Eメールまたはパスワードが違います' do
            click_button 'Login'
            expect(page).to have_content 'Eメールまたはパスワードが違います。'
          end
        end
    end
end
