require 'rails_helper'

describe 'ユーザ新規登録', type: :system do
  let!(:test_user) { create(:test_user) }

  before do
    visit new_user_registration_path
  end

  it 'ユーザ登録成功時' do
    fill_in '名前', with: 'Test000'
    fill_in 'メールアドレス', with: 'text000@example.com'
    fill_in 'パスワード', with: 'password'
    fill_in '確認', with: 'password'
    click_button 'Sign up'
    expect(page).to have_content 'アカウント登録が完了しました'
  end

  it 'ユーザ登録失敗時' do
    fill_in '名前', with: ''
    fill_in 'メールアドレス', with: ''
    fill_in 'パスワード', with: ''
    fill_in '確認', with: ''
    click_button 'Sign up'
    expect(page).to have_content '保存されませんでした'
  end
end