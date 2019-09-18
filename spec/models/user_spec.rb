require 'rails_helper'

RSpec.describe User, type: :model do
  describe '正常系' do
    context  'name, email,passwordの場合' do
      let(:user){ build(:user) }
      it { expect(user).to be_valid }
    end
  end
  
   describe '異常系' do
    before { user.valid? create(:user, email: 'test@example.com') }
    context 'emailがnilの場合' do
      let(:user) { build :user, email: nil }
      it { expect(user.errors[:email]).to include('を入力してください') }
    end
  
    context  'nameがnilのとき場合' do
      let(:user) { build :user, name: nil }
      it { expect(user.errors[:name]).to include('を入力してください') }
    end
  
    context  'passwordがnilのとき場合' do
      let(:user) { build :user, password: nil }
      it { expect(user.errors[:password]).to include('を入力してください') }
    end
    
    context  'nameが20文字以上の時場合' do
      let(:user) { build(:user, name: "a"*21) }
      it { expect(user.errors[:name]).to include('は20文字以内で入力してください') }
    end
  
    context  'passwordが6文字以下で場合' do
      let(:user){ build(:user, password: 'test') }
      it { expect(user.errors[:password]).to include('は6文字以上で入力してください') }
    end
  
    context  'emailがすでにあるとき場合' do
      let(:user) {build(:user, email: 'test@example.com')}
      it { expect(user.errors[:email]).to include('はすでに存在します') }
    end
  end
end
