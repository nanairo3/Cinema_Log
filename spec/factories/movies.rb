FactoryBot.define do
  factory :movie do
    title { "MyString" }
    original_title { "MyString" }
    poster_path { "MyString" }
    popularity { 1 }
    release_date { "MyString" }
    overview { "MyText" }
    video_key { "MyString" }
    run_time { 1 }
  end
end
