class UrlChecker

  def self.run

    UrlPattern.active.each do |url|
      puts "Start checking url pattern #{url.url} ..."

      url_string = UrlGenerator.run(url.url)
      if Url.find_by(url: url_string)
        puts "... url has been found and saved before: #{url_string}"
        next
      end

      today = Date.today.day
      check_from_day_of_month = average_publication_day() - 2
      if Url.count > 0 and check_from_day_of_month >= today
        puts "... check_from_day_of_month (= #{check_from_day_of_month}) not greater or equal Date.today.day (= #{today}): #{url_string}"
        next
      end

      response = request(url_string)
      if response.is_a?(Net::HTTPOK)
        puts "... url found: #{url_string}"
        title = UrlGenerator.run(url.title)
        attrs = {title: title, url: url_string}
        url = Url.create_or_find_by(attrs)
        if url.new_record? and not url.errors.empty?
          Rails.logger.error("#{self.name}: " + url.errors.inspect)
          Rails.logger.info("#{self.name}: " + attrs.inspect)
        else
          puts "... url saved: #{url_string}"
        end
      elsif response.is_a?(Net::HTTPNotFound)
        puts "... url does not exist now: #{url_string}"
      else
        Rails.logger.error("#{self.name}: Unknown problem while checking #{url_string}.")
      end
    end

  end

private

  def self.request(url_string)
    user_agent = UserAgent.all.shuffle.first.name

    HTTParty
      .head(url_string, :headers => { "User-Agent" => user_agent })
      .response
  end
  
def self.average_publication_day
  field = :created_at
  sql = Url.unscoped
    .select("strftime('%d', #{field}) as day")
    .order("#{field} desc")
    .limit(100)
    .to_sql

  days = ActiveRecord::Base.connection.execute(sql).map{|h| h["day"].to_i}

  days.sum / days.count
end

end