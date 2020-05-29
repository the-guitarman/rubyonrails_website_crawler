require 'rails_helper'

RSpec.describe "Welcomes", type: :request do

  describe "GET /" do
    it "returns http success" do
      get "/"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /index" do
    it "returns http redirect" do
      get "/welcome/index"
      expect(response).to have_http_status(:redirect)
    end
  end

end
