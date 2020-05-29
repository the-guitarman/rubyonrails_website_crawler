json.extract! url_pattern, :id, :url, :active, :created_at, :updated_at
json.url url_pattern_url(url_pattern, format: :json)
