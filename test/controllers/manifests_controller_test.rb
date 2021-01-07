require "test_helper"

class ManifestsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @manifest = manifests(:one)
  end

  test "should get index" do
    get manifests_url
    assert_response :success
  end

  test "should get new" do
    get new_manifest_url
    assert_response :success
  end

  test "should create manifest" do
    assert_difference('Manifest.count') do
      post manifests_url, params: { manifest: { fluent_version: @manifest.fluent_version, name: @manifest.name, react_dom_version: @manifest.react_dom_version, react_version: @manifest.react_version } }
    end

    assert_redirected_to manifest_url(Manifest.last)
  end

  test "should show manifest" do
    get manifest_url(@manifest)
    assert_response :success
  end

  test "should get edit" do
    get edit_manifest_url(@manifest)
    assert_response :success
  end

  test "should update manifest" do
    patch manifest_url(@manifest), params: { manifest: { fluent_version: @manifest.fluent_version, name: @manifest.name, react_dom_version: @manifest.react_dom_version, react_version: @manifest.react_version } }
    assert_redirected_to manifest_url(@manifest)
  end

  test "should destroy manifest" do
    assert_difference('Manifest.count', -1) do
      delete manifest_url(@manifest)
    end

    assert_redirected_to manifests_url
  end
end
