FactoryBot.define do
  factory :review do
    review_text { Faker::Lorem.characters(number: 20) }
    rate { Faker::Lorem.characters(number: 1) }
    shop
    user
  end
end