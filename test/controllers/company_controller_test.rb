require "minitest_helper"

class CompanyControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

end