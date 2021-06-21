require 'rails_helper'

RSpec.describe 'Shopモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    subject { shop.valid? }

    let(:user) { create(:user) }
    let!(:shop) { build(:shop, user_id: user.id) }

    context 'shop_nameカラム' do
      it '空欄でないこと' do
        shop.shop_name = ''
        is_expected.to eq false
      end
    end

    context 'shop_imageカラム' do
      it '空欄でないこと' do
        shop.shop_image = ''
        is_expected.to eq false
      end
    end

    context 'introductionカラム' do
      it '200文字以下であること: 200文字は〇' do
        shop.introduction = Faker::Lorem.characters(number: 200)
        is_expected.to eq true
      end
      it '200文字以下であること: 201文字は×' do
        shop.introduction = Faker::Lorem.characters(number: 201)
        is_expected.to eq false
      end
    end

    context 'address' do
      it '空欄でないこと' do
        shop.address = ''
        is_expected.to eq false
      end
    end

  end

  describe 'アソシエーションのテスト' do
    context 'Userモデルとの関係' do
      it 'N:1となっている' do
        expect(Shop.reflect_on_association(:user).macro).to eq :belongs_to
      end
      it "有効なtagを生成できる" do
        expect(create(:user)).to be_valid
      end
    end
  end
end