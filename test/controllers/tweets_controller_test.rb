require 'test_helper'

class TweetsControllerTest < ActionController::TestCase
  test "should get tweet" do
    get :tweet
    assert_response :success
  end

  test "should get feel" do
    get :feel
    assert_response :success
  end

  test "should get delete" do
    get :delete
    assert_response :success
  end

end
