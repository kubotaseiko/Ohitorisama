require 'rails_helper'

describe '[STEP3] ユーザログイン後のテスト(機能)' do

  context '投稿成功のテスト' do
    before do
      visit new_shop_path
      fill_in 'shop[shop_name]', with: Faker::Lorem.characters(number: 5)
      attach_file 'shop[shop_image]',with: "#{Rails.root}/spec/factories/test.jpg"
      fill_in 'shop[introduction]', with: Faker::Lorem.characters(number: 20)
      fill_in 'shop[address]', with: Gimei.address.kanji
      fill_in 'shop[tell]', with: Faker::Lorem.characters(number: 5)
      fill_in 'shop[holiday]', with: Faker::Lorem.characters(number: 5)
      fill_in 'shop[business_hours]', with: Faker::Lorem.characters(number: 5)
      # fill_in 'tag[tag_name]', with: Faker::Lorem.characters(number: 5)
    end

    it '自分の新しい投稿が正しく保存される' do
      expect { click_button '投稿する' }.to change(user.shops, :count).by(1)
    end
  end

end