require 'test_helper'

class UserAgentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user_agent = user_agents(:one)
  end

  test "should get index" do
    get user_agents_url
    assert_response :success
  end

  test "should get new" do
    get new_user_agent_url
    assert_response :success
  end

  test "should create user_agent" do
    assert_difference('UserAgent.count') do
      post user_agents_url, params: { user_agent: { name: @user_agent.name + '-1' } }
    end

    assert_redirected_to user_agent_url(UserAgent.last)
  end

  test "should show user_agent" do
    get user_agent_url(@user_agent)
    assert_response :success
  end

  test "should get edit" do
    get edit_user_agent_url(@user_agent)
    assert_response :success
  end

  test "should update user_agent" do
    patch user_agent_url(@user_agent), params: { user_agent: { name: @user_agent.name } }
    assert_redirected_to user_agent_url(@user_agent)
  end

  test "should destroy user_agent" do
    assert_difference('UserAgent.count', -1) do
      delete user_agent_url(@user_agent)
    end

    assert_redirected_to user_agents_url
  end
end
