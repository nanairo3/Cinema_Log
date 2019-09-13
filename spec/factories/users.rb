FactoryBot.define do
  factory :user do
    name { 'userA' }
    sequence(:email) { |n| "a#{n}@example.com" }
    password { 'apassword' }
    password_confirmation { 'apassword' }
  end
  
  factory :test_user, class: 'User' do
    name { 'test_user' }
    email { 'test@example.com' }
    password { 'testpass' }
    password_confirmation { 'testpass' }
  end
end
