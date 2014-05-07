require File.expand_path('../../test_helper', __FILE__)

class UserTest < ActiveSupport::TestCase
    fixtures :users

    test "email, username, password, and zip_code may not be nil for a user" do
        user = users(:ben)
        user.email = nil
        user.username = nil
        user.password = nil
        user.zip_code = nil

        assert user.invalid?
        assert_equal "can't be blank", user.errors[:email][0]
        assert_equal "can't be blank", user.errors[:username][0]
        assert_equal "can't be blank", user.errors[:password][0]
        assert_equal "can't be blank", user.errors[:zip_code][0]
    end

    test "a valid email must be provided" do
        user = users(:ben)
        email_valid_test(user)
    end

    test "username and password must be confirmed" do
        user = users(:ben)

        assert user.invalid?
        assert_equal "can't be blank", user.errors[:email_confirmation][0]
        assert_equal "can't be blank", user.errors[:password_confirmation][0]
    end

    test "zip_code must be a number, and exactly 5 digits long" do
        user = users(:ben)
        zip_code_test(user)
    end
end
