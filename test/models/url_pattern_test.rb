require 'test_helper'

class UrlPatternTest < ActiveSupport::TestCase

  test "presence of url" do
    up = UrlPattern.create
    assert up.errors.count == 1
    assert up.errors[:url] == ["can't be blank"]
  end

  test "uniqueness of url" do
    attributes = {
        url: 'https://www.example.com/test/%Y-%m'
    }

    up1 = UrlPattern.find_by(attributes)
    assert up1.nil?

    up2 = UrlPattern.create_or_find_by(attributes)
    assert up2.nil? == false
    assert up2.id?
    assert up2.new_record? == false

    up3 = UrlPattern.create_or_find_by(attributes)
    assert up3.new_record?
    assert up3.id.nil?
  end

  test "scopes tweeted and untweeted" do
    assert UrlPattern.active.count == 1
    assert UrlPattern.inactive.count == 1
  end

end
