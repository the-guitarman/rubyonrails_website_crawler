require "application_system_test_case"

class UserAgentsTest < ApplicationSystemTestCase
  setup do
    @user_agent = user_agents(:one)
  end

  test "visiting the index" do
    visit user_agents_url
    assert_selector "h1", text: "User Agents"
  end

  test "creating a User agent" do
    visit user_agents_url
    click_on "New User Agent"

    fill_in "Name", with: @user_agent.name
    click_on "Create User agent"

    assert_text "User agent was successfully created"
    click_on "Back"
  end

  test "updating a User agent" do
    visit user_agents_url
    click_on "Edit", match: :first

    fill_in "Name", with: @user_agent.name
    click_on "Update User agent"

    assert_text "User agent was successfully updated"
    click_on "Back"
  end

  test "destroying a User agent" do
    visit user_agents_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "User agent was successfully destroyed"
  end
end
