require 'rails_helper'

RSpec.describe 'Tweetモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    subject { tweet.valid? }

    let(:user) { create(:user) }
    let!(:tweet) { create(:tweet, user: user) }

    context '空白は投稿できない' do
      it 'tweetカラム' do
        tweet.tweet = ''
        is_expected.to eq false
      end
    end
    context 'tweetカラム' do
      it '200文字以下であること: 140文字は〇' do
        tweet.tweet = Faker::Lorem.characters(number: 140)
        is_expected.to eq true
      end
      it '200文字以下であること: 141文字は×' do
        tweet.tweet = Faker::Lorem.characters(number: 141)
        is_expected.to eq false
      end
    end
  end
  describe 'アソシエーションのテスト' do
    context 'Userモデルとの関係' do
      it 'N:1となっている' do
        expect(Tweet.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end
  end
end