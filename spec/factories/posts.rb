# frozen_string_literal: true

FactoryBot.define do
  factory :post do
    sequence(:content) { |n| "MyText#{n}" }
    association :user
    association :movie
  end
end
