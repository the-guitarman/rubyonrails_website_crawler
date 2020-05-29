class UrlPattern < ApplicationRecord
  validates :url, presence: true
  validates :url, uniqueness: true

  scope :active, -> { where(active: true) }
  scope :inactive, -> { where(active: false) }
end
