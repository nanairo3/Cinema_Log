# frozen_string_literal: true

require 'rails_helper'

describe 'serach', type: :system, js: true do
  let!(:user) { create(:user) }

  describe '正常系' do
    before do
      sign_in_as user
    end
    it '検索し映画詳細まで表示される' do
      fill_in 'keyword', with: 'ソニック'
      find('#icon_prefix2').native.send_key(:enter)
      expect(page).to have_content '検索結果'
      expect(page).to have_content 'ソニック・ザ・ムービー'
      click_link 'movie-id_454626'
      expect(page).to have_content '原題：Sonic the Hedgehog'
    end
    context '検索ワードを入力しない場合' do
      it '現在のページにリダイレクトされる' do
        fill_in 'keyword',  with: ' '
        expect(page).to have_content '注目の映画'
        expect(page).to_not have_content '検索結果'

        fill_in 'keyword',  with: 'ソニック'
        find('#icon_prefix2').native.send_key(:enter)
        expect(page).to_not have_content '注目の映画'
        expect(page).to have_content '検索結果'
      end
    end

    context '検索結果がない場合' do
      it '検索結果ページに、検索結果がないと表示される' do
        fill_in 'keyword', with: 'あああああ'
        find('#icon_prefix2').native.send_key(:enter)
        expect(page).to have_content '検索結果がありません'
      end
    end
  end
end
