require "test_helper"

class Public::FollowersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get public_followers_index_url
    assert_response :success
  end
end
