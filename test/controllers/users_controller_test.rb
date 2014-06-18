require 'test_helper'

class UsersControllerTest < ActionController::TestCase
    # test "the truth" do
    #   assert true
    # end
    #
    include Devise::TestHelpers
    fixtures :users

    test "user show action" do
        @user = users(:ben)
        sign_in @user

        get(:show, nil)
        assert_equal nil, flash[:notice]
        assert_response :success

        get(:show, {:id => @user.id + 1})
        assert_equal "Access denied.", flash[:notice]
        assert_response :redirect
        assert_redirected_to home_path

        get(:show, {:id => @user.id + 500})
        assert_response :redirect
        assert_equal "This user does not exist.", flash[:notice]

        sign_out @user
        get(:show, nil)
        assert_equal "You are not logged in.", flash[:notice]
        assert_response :redirect
    end
end
