json.extract! page, :id, :url, :crawler_config, :created_at, :updated_at
json.url page_url(page, format: :json)
