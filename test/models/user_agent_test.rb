require 'test_helper'

class UserAgentTest < ActiveSupport::TestCase

  test "presence of name" do
    ua = UserAgent.create
    assert ua.errors.count == 1
    assert ua.errors[:name] == ["can't be blank"]
  end

  test "uniqueness of name" do
    attributes = {
        name: 'UserAgent 1'
    }

    ua1 = UserAgent.find_by(attributes)
    assert ua1.nil?

    ua2 = UserAgent.create_or_find_by(attributes)
    assert ua2.nil? == false
    assert ua2.id?
    assert ua2.new_record? == false

    ua3 = UserAgent.create_or_find_by(attributes)
    assert ua2 == ua3
  end

end
