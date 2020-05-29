class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.create_or_find_by_attrs(attrs, *keys)
    object = find_by(find_by_hash(attrs, keys))
    object = create(attrs) unless object
    object
  end

private

  def self.find_by_hash(attrs, keys)
    keys = attrs.keys if keys.empty?
    attrs.dup.extract!(*keys)
  end
end
