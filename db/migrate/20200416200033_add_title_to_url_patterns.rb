class AddTitleToUrlPatterns < ActiveRecord::Migration[6.0]
  def change
    add_column :url_patterns, :title, :string
  end
end
