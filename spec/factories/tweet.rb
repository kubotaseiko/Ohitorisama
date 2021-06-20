FactoryBot.define do
  factory :tweet do
    tweet { Faker::Lorem.characters(number: 20) }
    user
  end
end