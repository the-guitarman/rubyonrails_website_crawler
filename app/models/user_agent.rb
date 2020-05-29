class UserAgent < ApplicationRecord
  validates :name, presence: true
end
