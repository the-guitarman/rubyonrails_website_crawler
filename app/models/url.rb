class Url < ApplicationRecord
  validates :url, presence: true
  validates :url, uniqueness: true

  default_scope { order(:created_at) }
  scope :tweeted, -> { where.not(tweeted_at: nil) }
  scope :untweeted, -> { where(tweeted_at: nil) }
end
