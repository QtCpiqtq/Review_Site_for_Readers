require "test_helper"

class Admin::FeelingAfterReadingsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_feeling_after_readings_index_url
    assert_response :success
  end
end
