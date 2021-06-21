# require 'rails_helper'

# describe '[STEP3] ユーザログイン後のテスト' do
#   let!(:user) { create(:user) }

#   before do
#     visit new_user_session_path
#     fill_in 'user[name]', with: user.name
#     fill_in 'user[password]', with: user.password
#     click_button 'ログイン'
#   end

#   describe 'Shopのテスト' do
#     context '投稿成功のテスト' do
#       visit new_shop_path
#       fill_in 'shop[shop_name]', with: Faker::Lorem.characters(number: 5)
#       # attach_file 'shop_shop_image', with: Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/test.jpg'), 'image/jpg')
#       fill_in 'shop[introduction]', with: Faker::Lorem.characters(number: 20)
#       fill_in 'shop[address]', with: Gimei.address.kanji
#       fill_in 'shop[tell]', with: Faker::Lorem.characters(number: 5)
#       fill_in 'shop[holiday]', with: Faker::Lorem.characters(number: 5)
#       fill_in 'shop[business_hours]', with: Faker::Lorem.characters(number: 5)
#       fill_in 'shop[tag_name]', with: Faker::Lorem.characters(number: 5)
#     end

#     it '自分の新しい投稿が正しく保存される' do
#       expect { click_button '投稿する' }.to change(Shop.all, :count).by(1)
#     end
#   end


# end