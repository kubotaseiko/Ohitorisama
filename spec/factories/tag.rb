FactoryBot.define do
  factory :tag do
    tag_name { Faker::Lorem.characters(number: 5) }
  end

  factory :tag2, class: Tag do
    tag_name { '焼き鳥' }
  end
end