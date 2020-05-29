class UrlCrawler
  attr_reader :page_url, :page_config, :body

  def self.run
    Page.active.find_each do |page|
      self.new(page).run()
    end
  end

  def initialize(page)
    @page_url = URI.parse(page.url)
    @page_config = page.crawler_config
  end

  def run
    puts "Start crawling page #{page_url().to_s} ..."

    highest_id_before = News.maximum(:id)

    random_sleep_before()
    unparsed_page_html = download_page_html()
    parsed_page_html = Nokogiri::HTML(unparsed_page_html)

    entries = 
      extract_news_entries_from_body(parsed_page_html)
      .map { |entry| extract_news_entry_data(entry) }
      .reverse
      .each do |entry_attrs| 
        news = News.create_or_find_by_attrs(entry_attrs, :title)
        if news.new_record? and not news.errors.empty?
          Rails.logger.error("#{self.class.name}: " + news.errors.inspect)
          Rails.logger.info("#{self.class.name}: " + entry_attrs.inspect)
        end
      end

    highest_id_after = News.maximum(:id)
    records_created_count = News
      .where("id > ?", highest_id_before)
      .where("id <= ?", highest_id_after)
      .count

    puts "New entries created: #{records_created_count}"
    puts "... end crawling page #{page_url().to_s}!"
  end

private

  def download_page_html
    user_agent = UserAgent.all.shuffle.first.name

    HTTParty
      .get(page_url().to_s, :headers => { "User-Agent" => user_agent })
      .response
      .body
  end

  def extract_news_entries_from_body(parsed_page_html)
    parsed_page_html.css(page_config()[:entries])
  end

  def extract_news_entry_data(parsed_entry_html)
    result = {
        url: page_url().to_s
    }

    page_config()[:entry].each do |attr, config|
      text_parts = []

      nodes = parsed_entry_html.css(config[:css])
      nodes.each do |node|
        temp_text = extract_node_data(node, config)
        if attr == :body
          links = extract_link_data(node)
          temp_text = add_links_to_text(temp_text, links)
        end
        
        temp_text =
          get_node_data_prefix(node) +
          temp_text +
          get_node_data_postfix(node)
        
        text_parts.push(parse_node_data(temp_text, config))
      end

      result[attr] = text_parts.join()
    end

    return result
  end

  def add_links_to_text(text, links)
    unless links.empty?
      links = links.join(', ')
      text = text.blank? ? links : "#{text} (#{links})"
    end
    text
  end

  def extract_node_data(node, config)
    if config_type_is?(:text, config)
      node.text.strip
    else
      node.get_attribute(config[:attr]).to_s.strip
    end
  end

  def extract_link_data(node) 
    result = []
    node.children.each do |n|
      if n.name.to_sym == :a
        url = URI.parse(n.get_attribute(:href))
        url.scheme = page_url().scheme
        url.host = page_url().host
        result.push(url.to_s)
      end
    end
    result
  end

  def parse_node_data(text, config)
    if config_type_is?(:datetime, config) and not text.empty?
      DateTime.parse(text)
    else
      text
    end
  end

  def get_node_data_prefix(node)
    case node.name
      when 'li'
        '- '
      else 
        ''
    end
  end

  def get_node_data_postfix(node)
    case node.name
      when 'p'
        "\n\n"
      when 'li'
        "\n"
      else 
        ''
    end
  end

  def config_type_is?(type_expected, config)
    [type_expected.to_sym, type_expected.to_s].include?(config[:type])
  end

  def random_sleep_before()
    seconds_to_wait = Rails.env.test? ? 0 : rand(5..300)
    Rails.logger.info("#{self.class.name}: Waiting for #{seconds_to_wait} seconds before start of the crawler ...")
    sleep(seconds_to_wait)
  end
end