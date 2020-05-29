require "application_system_test_case"

class UrlPatternsTest < ApplicationSystemTestCase
  setup do
    @url_pattern = url_patterns(:one)
  end

  test "visiting the index" do
    visit url_patterns_url
    assert_selector "h1", text: "Url Patterns"
  end

  test "creating a Url pattern" do
    visit url_patterns_url
    click_on "New Url Pattern"

    check "Active" if @url_pattern.active
    fill_in "Url", with: @url_pattern.url
    click_on "Create Url pattern"

    assert_text "Url pattern was successfully created"
    click_on "Back"
  end

  test "updating a Url pattern" do
    visit url_patterns_url
    click_on "Edit", match: :first

    check "Active" if @url_pattern.active
    fill_in "Url", with: @url_pattern.url
    click_on "Update Url pattern"

    assert_text "Url pattern was successfully updated"
    click_on "Back"
  end

  test "destroying a Url pattern" do
    visit url_patterns_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Url pattern was successfully destroyed"
  end
end
