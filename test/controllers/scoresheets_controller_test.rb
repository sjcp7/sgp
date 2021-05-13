require "test_helper"

class ScoresheetsControllerTest < ActionDispatch::IntegrationTest
  test "should get ac" do
    get scoresheets_ac_url
    assert_response :success
  end

  test "should get trimestral" do
    get scoresheets_trimestral_url
    assert_response :success
  end

  test "should get global" do
    get scoresheets_global_url
    assert_response :success
  end
end
