require 'test_helper'

class UrlPatternsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @url_pattern = url_patterns(:one)
  end

  test "should get index" do
    get url_patterns_url
    assert_response :success
  end

  test "should get new" do
    get new_url_pattern_url
    assert_response :success
  end

  test "should create url_pattern" do
    assert_difference('UrlPattern.count') do
      post url_patterns_url, params: { url_pattern: { active: @url_pattern.active, url: @url_pattern.url + '-1' } }
    end

    assert_redirected_to url_pattern_url(UrlPattern.last)
  end

  test "should show url_pattern" do
    get url_pattern_url(@url_pattern)
    assert_response :success
  end

  test "should get edit" do
    get edit_url_pattern_url(@url_pattern)
    assert_response :success
  end

  test "should update url_pattern" do
    patch url_pattern_url(@url_pattern), params: { url_pattern: { active: @url_pattern.active, url: @url_pattern.url } }
    assert_redirected_to url_pattern_url(@url_pattern)
  end

  test "should destroy url_pattern" do
    assert_difference('UrlPattern.count', -1) do
      delete url_pattern_url(@url_pattern)
    end

    assert_redirected_to url_patterns_url
  end
end
