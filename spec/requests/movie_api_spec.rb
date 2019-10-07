require 'rails_helper'

RSpec.describe "MovieApi", type: :request do
  describe "GET /movie_api" do
    it "works! (now write some real specs)" do
      get movie_apis_path
      expect(response).to have_http_status(200)
    end
  end
end
