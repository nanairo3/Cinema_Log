FactoryBot.define do
  factory :movie do
    json {
      {
        id: 111111,
        title: "title",
        original_title: "original_title",
        poster_path: "poster_path",
        popularity: 1,
        release_date: "release_date",
        overview: "overview",
        video_: "video_key",
      }
    }
  end
end
