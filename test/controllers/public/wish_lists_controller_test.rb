require "test_helper"

class Public::WishListsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get public_wish_lists_index_url
    assert_response :success
  end
end
