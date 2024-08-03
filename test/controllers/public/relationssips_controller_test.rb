require "test_helper"

class Public::RelationssipsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get public_relationssips_index_url
    assert_response :success
  end
end
