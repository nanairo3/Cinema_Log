# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe '正常系' do
    context  '正しくname, email,passwordを入力した場合' do
      let(:user) { build(:user) }
      it { expect(user).to be_valid }
    end
  end

   describe '異常系' do
    context 'emailがnilの場合' do
      let(:user) { build :user, email: nil }

      it 'ユーザー登録できない' do
        user.valid?
        expect(user.errors[:email]).to include('を入力してください')
      end
    end

    context 'nameがnilの場合' do
      let(:user) { build :user, name: nil }

      it 'ユーザー登録できない' do
        user.valid?
        expect(user.errors[:name]).to include('を入力してください')
      end
    end

    context 'passwordがnilの場合' do
      let(:user) { build :user, password: nil }

      it 'ユーザー登録できない' do
        user.valid?
        expect(user.errors[:password]).to include('を入力してください')
      end
    end

    context 'nameが20文字以上の場合' do
      let(:user) { build(:user, name: 'a'*21) }

      it 'ユーザー登録できない' do
        user.valid?
        expect(user.errors[:name]).to include('は20文字以内で入力してください')
      end
    end

    context 'passwordが6文字以下の場合' do
      let(:user) { build(:user, password: 'test') }

      it 'ユーザー登録できない' do
        user.valid?
        expect(user.errors[:password]).to include('は6文字以上で入力してください')
      end
    end

    context 'emailがすでにある場合' do
      before { create(:user, email: 'test@example.com') }
      let(:user) { build(:user, email: 'test@example.com') }

      it 'ユーザー登録できない' do
        user.valid?
        expect(user.errors[:email]).to include('はすでに存在します')
      end
    end
  end
end
