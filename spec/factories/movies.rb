FactoryBot.define do
  factory :movie do
    sequence(:id)  { |n| 11111 + n }
    sequence(:title) { |n| "#{n}movie"}
    sequence(:original_title) { |n| "#{n}movie"}
    poster_path { "poster_path" }
    popularity { 1 }
    release_date { "2019-10-17" }
    overview { "overview" }
  end
end