require 'rails_helper'

RSpec.describe Like, type: :model do
  let!(:user){ create(:user) }
  let!(:post){ create(:post) }
  
  describe '正常系' do
    context '正しくいいねできる場合' do
      let(:like){ build(:like, user: user, post: post) }
      it { expect(like).to be_valid }
    end
  end
end
