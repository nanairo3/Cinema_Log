FactoryBot.define do
  factory :user do
    name { 'userA' }
    sequence(:email) { |n| "a#{n}@example.com" }
    password { 'apassword' }
    password_confirmation { 'apassword' }
  end
end
