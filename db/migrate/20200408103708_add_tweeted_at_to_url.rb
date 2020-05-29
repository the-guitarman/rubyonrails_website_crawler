class AddTweetedAtToUrl < ActiveRecord::Migration[6.0]
  def change
    add_column :urls, :tweeted_at, :datetime
  end
end
