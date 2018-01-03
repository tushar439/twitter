require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  test "should get signup" do
    get :signup
    assert_response :success
  end

  test "should get signin" do
    get :signin
    assert_response :success
  end

  test "should get profile" do
    get :profile
    assert_response :success
  end

  test "should get logout" do
    get :logout
    assert_response :success
  end

end
