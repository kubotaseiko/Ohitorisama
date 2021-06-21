require 'rails_helper'

RSpec.describe 'Reviewモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    subject { review.valid? }

    let(:user) { create(:user) }
    let(:shop) { create(:shop, user: user) }
    let!(:review) { build(:review, shop: shop ) }

    context 'review_textカラム' do
      it '空白カラムでは投稿できない' do
        review.review_text = ''
        is_expected.to eq false
      end

      it '200文字以下であること: 200文字は〇' do
        review.review_text = Faker::Lorem.characters(number: 200)
        is_expected.to eq true
      end
      it '200文字以下であること: 201文字は×' do
        review.review_text = Faker::Lorem.characters(number: 201)
        is_expected.to eq false
      end
    end
    context 'rateカラム' do
      it '空白カラムでは投稿できない' do
        review.rate = ''
        is_expected.to eq false
      end
    end
  end

  describe 'アソシエーションのテスト' do
    context 'モデルとの関係' do
      it 'UserモデルN:1となっている' do
        expect(Review.reflect_on_association(:user).macro).to eq :belongs_to
      end
      it "ShopモデルN:1となっている" do
        expect(Review.reflect_on_association(:shop).macro).to eq :belongs_to
      end
    end
  end
end