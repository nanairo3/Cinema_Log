require 'rails_helper'

describe 'ログイン機能', type: :system do
  let!(:user) { create(:user) }
  let!(:test_user) { create(:test_user) }

  before do
    visit new_user_session_path
  end

  context 'ログイン成功時' do
    it 'ログインできる' do
      fill_in 'session_email', with: user.email
      fill_in 'session_password', with: user.password
      click_button 'Login'
      expect(page).to have_content 'ログインしました。'
    end
  end

  context 'ログイン失敗時' do
    it '間違った組み合わせ' do
      fill_in 'session_email', with: user.email
      fill_in 'session_password', with: 'nonpassword'
      click_button 'Login'
      expect(page).to have_content 'Eメールまたはパスワードが違います。'
    end

    it '未入力の時' do
      click_button 'Login'
      expect(page).to have_content 'Eメールまたはパスワードが違います。'
    end
  end
end