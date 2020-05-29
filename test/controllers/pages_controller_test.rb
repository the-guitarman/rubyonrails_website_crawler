require 'test_helper'

class PagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @page = pages(:one)
  end

  test "should get index" do
    get pages_url
    assert_response :success
  end

  test "should get new" do
    get new_page_url
    assert_response :success
  end

  test "should create page" do
    assert_difference('Page.count') do
      attributes = {
        url: @page.url+'-1',
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
      post pages_url, params: { page: attributes }
    end

    assert_redirected_to page_url(Page.last)
  end

  test "should show page" do
    get page_url(@page)
    assert_response :success
  end

  test "should get edit" do
    get edit_page_url(@page)
    assert_response :success
  end

  test "should update page" do
    attributes = {
        url: @page.url,
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
    patch page_url(@page), params: { page: attributes }    
    assert_redirected_to page_url(@page)
  end

  test "should destroy page" do
    assert_difference('Page.count', -1) do
      delete page_url(@page)
    end

    assert_redirected_to pages_url
  end
end
