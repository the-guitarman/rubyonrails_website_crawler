require 'test_helper'

class PageTest < ActiveSupport::TestCase

  test "presence of url" do
    p = Page.create
    assert p.errors.count == 3
    assert p.errors[:url] == ["can't be blank"]
    assert p.errors[:crawler_config] == ["can't be blank", "has to be a hash"]
  end

  test "uniqueness of url" do
    attributes = {
        url: 'https://www.example.com/test/1',
        crawler_config: {
            :entries => "div.item[itemprop=\"blogPost\"]", 
            :entry => {
                :title => {
                    :css => ".page-header h2", 
                    :type => "text"
                }, 
                :published_at=>{
                    :css=>"dl.article-info dd.create time[itemprop=dateCreated]", 
                    :type=>"datetime", 
                    :attr=>"datetime"
                }, 
                :body=>{
                    :css=>"p, ul li", 
                    :type=>"text"
                }
            }
        }
    }

    p1 = Page.find_by(attributes)
    assert p1.nil?

    p2 = Page.create_or_find_by_attrs(attributes, :url)
    assert p2.nil? == false
    assert p2.new_record? == false
    assert p2.id?

    p3 = Page.create_or_find_by_attrs(attributes, :url)
    assert p3.nil? == false
    assert p3.new_record? == false
    assert p3.id?

    assert p2.id == p3.id
  end

  test "scopes tweeted and untweeted" do
    assert Page.active.count == 1
    assert Page.inactive.count == 1
  end

end
