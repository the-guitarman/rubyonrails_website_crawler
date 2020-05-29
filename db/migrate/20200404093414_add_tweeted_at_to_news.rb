class AddTweetedAtToNews < ActiveRecord::Migration[6.0]
  def change
    add_column :news, :tweeted_at, :datetime, after: :published_at
  end
end
