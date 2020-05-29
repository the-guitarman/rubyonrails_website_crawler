class UrlGenerator

  def self.run(url)
    replace_datetime_params(url)
  end

  def self.replace_datetime_params(url)
    DateTime.now.strftime(url)
  end
  
end
