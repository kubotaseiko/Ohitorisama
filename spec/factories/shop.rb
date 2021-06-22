
FactoryBot.define do
  factory :shop do
    shop_name { Faker::Lorem.characters(number: 5) }
    shop_image { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/test.jpg'), 'image/jpg') }
    introduction { Faker::Lorem.characters(number: 20) }
    address {Gimei.address.kanji}
    tell { Faker::Lorem.characters(number: 5) }
    holiday { Faker::Lorem.characters(number: 5) }
    business_hours { Faker::Lorem.characters(number: 5) }
    user
    
    after(:create) do |shop|
      create(:tagmap, shop: shop, tag: create(:tag))
    end
  end  
  
  factory :shop2, class: Shop do
    shop_name { '居酒屋鹿児島店' }
    shop_image { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/test.jpg'), 'image/jpg') }
    introduction { Faker::Lorem.characters(number: 20) }
    address { '鹿児島県鹿児島市' }
    tell { Faker::Lorem.characters(number: 5) }
    holiday { Faker::Lorem.characters(number: 5) }
    business_hours { Faker::Lorem.characters(number: 5) }
    user
    
    after(:create) do |shop|
      create(:tagmap, shop: shop, tag: create(:tag2))
    end
  end
end