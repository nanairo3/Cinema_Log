require 'rails_helper'

describe '映画ホームページ', type: :system do
  describe '正常系' do
    context '映画一覧が表示される場合' do
      it '映画一覧が表示される' do
        visit root_path
        expect(page).to have_content '注目の映画'
      end
    end
  end
end