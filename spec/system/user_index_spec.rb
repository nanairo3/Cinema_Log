require 'rails_helper'

describe 'ユーザ一覧機能', type: :system do
  let!(:user) { create(:user) }
  let!(:other_user1) { create(:other_user) }
  let!(:other_user2) { create(:other_user) }

  before do
    sign_in_as user
  end

  it 'ユーザ一覧が表示される' do
    link = find('a', text: 'ユーザ一覧')
    link.click
    expect(page).to have_content user.name
    expect(page).to have_content other_user1.name
    expect(page).to have_content other_user2.name
  end

  context 'ユーザ一覧でユーザ名をクリック' do
    it 'ユーザ詳細画面が表示される' do
      link = find('a', text: 'ユーザ一覧')
      link.click
      link = find('a', text: other_user1.name)
      link.click
      expect(page).to have_content other_user1.name
    end
  end
end