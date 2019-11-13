# frozen_string_literal: true

require 'rails_helper'

describe 'ログアウト機能', type: :system do
  before do
    sign_in_as create(:user)
  end
  
  it 'ログアウトする' do
    click_link 'Logout'
    expect(page).to have_content 'ログアウトしました。'
  end
end