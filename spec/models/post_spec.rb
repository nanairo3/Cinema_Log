# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Post, type: :model do
  describe '正常系' do
    context '正しくcontentを入力した場合' do
      let(:post) { build(:post) }
      it { expect(post).to be_valid }
    end
  end

  describe '異常系' do
    context 'contentがnilの場合' do
      let(:post) { build :post, content: nil }
      it '投稿できない' do
        post.valid?
        expect(post.errors[:content]).to include('を入力してください')
      end
    end

    context 'contentが500文字以上の場合' do
      let(:post) { build :post, content: 'a' * 501 }
      it '投稿できない'do
        post.valid?
        expect(post.errors[:content]).to include('は500文字以内で入力してください')
      end
    end
  end
end
