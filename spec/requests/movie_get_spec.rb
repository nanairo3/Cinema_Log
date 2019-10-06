require 'json'
require_relative 'rails_helper'

describe 'get_movie spec' do
  let!(:test_faraday) do
    stub_con = Faraday.new do |conn|
      conn.adapter :test, Faraday::Adapter::Test::Stubs.new do |stub|
        stub.get ("https://api.themoviedb.org/3/genre/movie/list") do
          [200, {}, {api_key: Rails.application.credentials.api_key, language: "ja-JP", page: 1, region: "JP"}.to_json]
        end
      end
    end
    instance = TestFaraday.new
    allow(instance).to receive(:connection).and_return(stub_con)
    return instance
  end

  it 'faraday test' do
    res = test_faraday.get
    expect(res.status).to eq 200
  end
end