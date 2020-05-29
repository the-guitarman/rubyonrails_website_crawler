class News < ApplicationRecord
  validates :title, presence: true
  #validates :title, uniqueness: { scope: :published_at }
  validates :url, presence: true
  validates :body, presence: true
  validates :published_at, presence: true

  default_scope { order(:published_at) }
  scope :tweeted, -> { where.not(tweeted_at: nil) }
  scope :untweeted, -> { where(tweeted_at: nil) }
  scope :tweeted_but_updated, -> { tweeted.where("strftime('%s', tweeted_at) < strftime('%s', updated_at)") }
end
