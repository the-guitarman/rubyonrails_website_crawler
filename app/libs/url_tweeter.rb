class UrlTweeter
  TWITTER_CLIENT_KEYS = {
    :consumer_key    => 'CONSUMER_KEY',
    :consumer_secret => 'CONSUMER_SECRET',
    :access_token    => 'ACCESS_TOKEN',
    :access_secret   => 'ACCESS_SECRET',
  }

  attr_reader :client, :tweet_counter

  def self.run
    self.new.run
  end

  def initialize(client = nil)
    if client.is_a?(Twitter::REST::Client) or 
       (
        client.class.name.starts_with?('RSpec') and 
        client.instance_variable_get(:@name).to_s == 'Twitter::REST::Client'
       )
      @client = client
    else
      @client = get_twitter_client()
    end

    @tweet_counter = 0
  end

  def run
    News.tweeted_but_updated.each do |news|
      tweet_a_news_record_again(news)
    end

    News.untweeted.each do |news|
      tweet_a_new_news_record(news)
    end

    Url.untweeted.each do |url|
      tweet_a_new_url_record(url)
    end
  end

private
  
  def get_twitter_client
    if twitter_client_keys?

      client = Twitter::REST::Client.new do |config|
        config.consumer_key        = ENV[TWITTER_CLIENT_KEYS[:consumer_key]]
        config.consumer_secret     = ENV[TWITTER_CLIENT_KEYS[:consumer_secret]]
        config.access_token        = ENV[TWITTER_CLIENT_KEYS[:access_token]]
        config.access_token_secret = ENV[TWITTER_CLIENT_KEYS[:access_secret]]
      end

    else

      keys = TWITTER_CLIENT_KEYS.values.to_sentence(last_word_connector: ' or ')
      Rails.logger.error("#{self.class.name}: At least one environment key (#{keys}) is not set to initialize the twitter client.")
      nil

    end
  end 

  def twitter_client_keys?
    TWITTER_CLIENT_KEYS.any?{|k, env_key| ENV[env_key].blank?} == false
  end

  def tweet_a_new_news_record(news)
    tweet_a_news_record(news, "#{I18n.t('new_news_entry')} #{I18n.t('is_online')}.")
  end

  def tweet_a_news_record_again(news)
    tweet_a_news_record(news, "#{I18n.t('news_entry')} #{I18n.t('has_been_updated')}.")
  end

  def tweet_a_news_record(news, message)
    hash_tags = ['News', 'Claußnitz']
    msg = message(news.title, message, news.url, hash_tags)
    unless msg.blank?
      Rails.logger.info("#{self.class.name}: #{msg}")
      tweet_the_message(news, msg)
    end
  end

  def tweet_a_new_url_record(url)
    hash_tags = ['Amtsblatt', 'Claußnitz']
    msg = message('', "#{url.title} #{I18n.t('is_online')}.", url.url, hash_tags)
    unless msg.blank?
      Rails.logger.info("#{self.class.name}: #{msg}")
      tweet_the_message(url, msg)
    end
  end

  def message(title = '', text = '', link = '', hash_tags = [])
    msg = ''
    msg = text + " \n " unless text.blank?
    msg = "#{msg} \"#{title}\" \n " unless title.blank?
    msg = "#{msg} #{link} \n " unless link.blank?
    msg = "#{msg} " + hash_tags.map{|ht| "##{ht}"}.join(' ') unless hash_tags.empty?
  end

  def tweet_the_message(object, msg, options = {})
    random_sleep_before_tweet()

    client().update(msg, options)
    object.update_attribute(:tweeted_at, DateTime.now)

    @tweet_counter = @tweet_counter + 1
  end

  def random_sleep_before_tweet()
    seconds_to_wait = @tweet_counter == 0 ? 0 : rand(5..300)
    Rails.logger.info("#{self.class.name}: Waiting for #{seconds_to_wait} seconds before tweet ...")
    sleep(seconds_to_wait)
  end
end