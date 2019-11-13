# frozen_string_literal: true

require 'rails_helper'

describe 'ユーザ一覧機能', type: :system do
  let!(:users) { create_list(:user, 3) }
    
  before do
    sign_in_as users.first
  end
  
  describe '正常系' do
    context 'ユーザ一覧が表示される場合' do
      it 'ユーザ一覧が表示される' do
        link = find('a', text: 'ユーザ一覧')
        link.click
        expect(page).to have_content users[0].name
        expect(page).to have_content users[1].name
        expect(page).to have_content users[2].name
      end
    end
  
    context 'ユーザ一覧でユーザ名をクリックした場合' do
      it 'クリックしたユーザ名が表示される' do
        link = find('a', text: 'ユーザ一覧')
        link.click
        link = find('a', text: users[1].name)
        link.click
        expect(page).to have_content users[1].name
      end
    end
  end
end