require 'test_helper'

class NewsTest < ActiveSupport::TestCase

  test "presence of title, url and published_at" do
    n = News.create
    assert n.errors.count == 4
    assert n.errors[:title] == ["can't be blank"]
    assert n.errors[:body] == ["can't be blank"]
    assert n.errors[:url] == ["can't be blank"]
    assert n.errors[:published_at] == ["can't be blank"]
  end

  test "uniqueness of title" do
    attributes = {
        title: 'Title 1', 
        url: 'https://www.example.com/news/1',
        body: 'Text 1',
        published_at: DateTime.now
    }

    n1 = News.find_by(attributes)
    assert n1.nil?

    n2 = News.create_or_find_by_attrs(attributes, :title)
    assert n2.nil? == false
    assert n2.new_record? == false
    assert n2.id?

    n3 = News.create_or_find_by_attrs(attributes, :title)
    assert n3.nil? == false
    assert n3.new_record? === false
    assert n3.id?

    assert n2.id == n3.id
  end

  test "scopes tweeted and untweeted" do
    assert News.tweeted.count == 1
    assert News.untweeted.count == 1
  end

end
