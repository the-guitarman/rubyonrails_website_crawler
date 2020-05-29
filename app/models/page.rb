class Page < ApplicationRecord
  validates :url, presence: true
  #validates :url, uniqueness: true
  validates :crawler_config, presence: true
  validate :crawler_config_hash

  serialize :crawler_config

  after_initialize do |patient|
    patient.crawler_config = [] if patient.crawler_config == nil
  end

  scope :active, -> { where(active: true) }
  scope :inactive, -> { where(active: false) }

private

  def crawler_config_hash
    if crawler_config.is_a?(Hash)
      crawler_config_hash_has_keys?(crawler_config, :entries, String)
      if crawler_config_hash_has_keys?(crawler_config, :entry, Hash)

      end  
    else
      errors.add(:crawler_config, "has to be a hash")
    end
  end

  def crawler_config_hash_has_keys?(hash, key, type)
    result = true
    if not hash.key?(key)
      errors.add(:crawler_config, "key #{key} is missing")
      result = false
    elsif not hash[key].is_a?(type)
      errors.add(:crawler_config, "key #{key} has wrong type")
      result = false
    end
    result
  end
end
