require 'test_helper'

class UrlTest < ActiveSupport::TestCase

  test "presence of url" do
    u = Url.create
    assert u.errors.count == 1
    assert u.errors[:url] == ["can't be blank"]
  end

  test "uniqueness of url" do
    attributes = {
        url: 'https://www.example.com/test/1'
    }

    u1 = Url.find_by(attributes)
    assert u1.nil?

    u2 = Url.create_or_find_by(attributes)
    assert u2.nil? == false
    assert u2.id?
    assert u2.new_record? == false

    u3 = Url.create_or_find_by(attributes)
    assert u3.new_record?
    assert u3.id.nil?
  end

  test "scopes tweeted and untweeted" do
    assert Url.tweeted.count == 1
    assert Url.untweeted.count == 1
  end
  
end
