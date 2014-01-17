require 'test_helper'

class Users::OmniauthCallbacksControllerTest < ActionController::TestCase
  test "should get vkontakte" do
    get :vkontakte
    assert_response :success
  end

end
