require "test_helper"

class StudentTestsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get student_tests_index_url
    assert_response :success
  end

  test "should get create" do
    get student_tests_create_url
    assert_response :success
  end

  test "should get update" do
    get student_tests_update_url
    assert_response :success
  end
end
