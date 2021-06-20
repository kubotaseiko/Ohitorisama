FactoryBot.define do
  factory :admin do
  email { 'test@test' }
  password { 'password' }
  password_confirmation { 'password' }
  end
end