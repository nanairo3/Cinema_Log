FactoryBot.define do
  factory :movie do
    [{
      "id" => 111111,
      "title" =>"movie",
      "original_title" => "movie",
      "poster_path" => "poster_path",
      "popularity" => 1,
      "release_date" => "release_date",
      "overview" => "overview"
    }]
  end
end