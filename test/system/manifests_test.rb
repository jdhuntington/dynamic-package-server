require "application_system_test_case"

class ManifestsTest < ApplicationSystemTestCase
  setup do
    @manifest = manifests(:one)
  end

  test "visiting the index" do
    visit manifests_url
    assert_selector "h1", text: "Manifests"
  end

  test "creating a Manifest" do
    visit manifests_url
    click_on "New Manifest"

    fill_in "Fluent version", with: @manifest.fluent_version
    fill_in "Name", with: @manifest.name
    fill_in "React dom version", with: @manifest.react_dom_version
    fill_in "React version", with: @manifest.react_version
    click_on "Create Manifest"

    assert_text "Manifest was successfully created"
    click_on "Back"
  end

  test "updating a Manifest" do
    visit manifests_url
    click_on "Edit", match: :first

    fill_in "Fluent version", with: @manifest.fluent_version
    fill_in "Name", with: @manifest.name
    fill_in "React dom version", with: @manifest.react_dom_version
    fill_in "React version", with: @manifest.react_version
    click_on "Update Manifest"

    assert_text "Manifest was successfully updated"
    click_on "Back"
  end

  test "destroying a Manifest" do
    visit manifests_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Manifest was successfully destroyed"
  end
end
