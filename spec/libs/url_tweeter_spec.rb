require 'rails_helper'

RSpec.describe "UrlTweeter", "#tweet" do
  fixtures :all

  context "UrlTweeter" do
    it "should tweet a news message" do

      expect(1).to eq 1

      client = Twitter::REST::Client.new do |config|
        config.consumer_key        = 'test_consumer_key'
        config.consumer_secret     = 'test_consumer_secret'
        config.access_token        = 'test_access_token'
        config.access_token_secret = 'test_access_token_secret'
      end

      client = double(Twitter::REST::Client)
      allow(client).to receive(:update) { Twitter::Tweet.new(id: -1, text:'test tweet') }

      expect(News.count).to eq 2
      expect(News.untweeted.count).to eq 1
      expect(Url.untweeted.count).to eq 1

      UrlTweeter.new(client).run

      expect(News.untweeted.count).to eq 0
      expect(Url.untweeted.count).to eq 0
    end
  end
end