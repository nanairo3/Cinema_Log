require 'rails_helper'

RSpec.describe User, type: :model do
  describe '成功' do
    it 'name, email,passwordのとき成功' do
      user = build(:user)
      expect(user).to be_valid
    end
  end
  
   describe '失敗' do
    it 'emailがnilのとき無効' do
      user = build(:user, email: nil)
      user.valid?
      expect(user.errors[:email]).to include('を入力してください')
    end
  
    it 'nameがnilのとき無効' do
      user = build(:user, name: nil)
      user.valid?
      expect(user.errors[:name]).to include('を入力してください')
    end
  
    it 'passwordがnilのとき無効' do
      user = build(:user, password: nil)
      user.valid?
      expect(user.errors[:password]).to include('を入力してください')
    end
    
    it 'nameが20文字以上の時無効' do
      user = build(:user, name: "a"*21)
      user.valid?
      expect(user.errors[:name]).to include('は20文字以内で入力してください')
    end
  
    it 'passwordが6文字以下で無効' do
      user = build(:user, password: 'test')
      user.valid?
      expect(user.errors[:password]).to include('は6文字以上で入力してください')
    end
  
    it 'emailがすでにあるとき無効' do
      create(:user, email: 'test@example.com')
      user = build(:user, email: 'test@example.com')
      user.valid?
      expect(user.errors[:email]).to include('はすでに存在します')
    end
  end
end
