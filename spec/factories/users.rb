# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "user#{n}" }
    sequence(:email) { |n| "a#{n}@example.com" }
    password { 'password' }
    password_confirmation { 'password' }
  end
end