FactoryBot.define do
  factory :movie do
      id  { 111111 }
      sequence(:title) { |n| "#{n}movie"}
      sequence(:original_title) { |n| "#{n}movie"}
      poster_path { "poster_path" }
      popularity { 1 }
      release_date { "release_date" }
      overview { "overview" }
  end
end