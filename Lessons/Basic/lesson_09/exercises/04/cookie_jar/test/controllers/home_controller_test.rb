require 'test_helper'

class HomeControllerTest < ActionDispatch::IntegrationTest
  test "should get set_cookies" do
    get home_set_cookies_url
    assert_response :success
  end

  test "should get show_cookies" do
    get home_show_cookies_url
    assert_response :success
  end

  test "should get delete_cookies" do
    get home_delete_cookies_url
    assert_response :success
  end

end
