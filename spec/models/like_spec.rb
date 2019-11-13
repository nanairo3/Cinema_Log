# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Like, type: :model do
  let!(:user) { create(:user) }
  let!(:post) { create(:post) }
  
  describe '正常系' do
    context '正しくいいねできる場合' do
      let(:like) { build(:like, user: user, post: post) }
      it { expect(like).to be_valid }
    end
  end
  
  describe '異常系' do
    context '複数件登録する場合' do
      before { create(:like, user: user, post: post) }
      let!(:like) { build(:like, user: user, post: post) }
      
      it 'いいねを登録できない' do
        like.valid?
        expect(like.errors[:post_id]).to include('はすでに存在します')
      end
    end
  end
end
