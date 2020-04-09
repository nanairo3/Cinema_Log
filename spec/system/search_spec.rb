require 'rails_helper'

describe 'serach', type: :system, js: true do
  let!(:user) { create(:user) }

  describe '正常系' do
    before do
      sign_in_as user
    end
    it '検索し映画詳細まで表示される' do
      fill_in "keyword",	with: "ソニック"
      find('#icon_prefix2').native.send_key(:enter)
      expect(page).to have_content "検索結果"
      expect(page).to have_content "ソニック・ザ・ムービー"
      click_link "movie-id_454626"
      expect(page).to have_content "原題：Sonic the Hedgehog"
    end
  end
end