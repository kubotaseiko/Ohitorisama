FactoryBot.define do
  factory :shop do
    shop_name { Faker::Lorem.characters(number: 5) }
    shop_image_id { Faker::Lorem.characters(number: 20) }
    introduction { Faker::Lorem.characters(number: 20) }
    address {Gimei.address.kanji}
    tell { Faker::Lorem.characters(number: 5) }
    holiday { Faker::Lorem.characters(number: 5) }
    business_hours { Faker::Lorem.characters(number: 5) }
    user
  end
end