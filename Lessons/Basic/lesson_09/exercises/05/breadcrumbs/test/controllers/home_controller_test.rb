require 'test_helper'

class HomeControllerTest < ActionDispatch::IntegrationTest
  test "should get ping" do
    get home_ping_url
    assert_response :success
  end

  test "should get pong" do
    get home_pong_url
    assert_response :success
  end

  test "should get index" do
    get home_index_url
    assert_response :success
  end

end
