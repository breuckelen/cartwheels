require File.expand_path('../../test_helper', __FILE__)

class UserTest < ActiveSupport::TestCase
    fixtures :users

    test "email, username, password, zip_code should be present" do
        user = users(:ben)
        presence_test(user, :email)
        presence_test(user, :email_encrypted)
        presence_test(user, :password)
        presence_test(user, :password_encrypted)
        presence_test(user, :username)
        presence_test(user, :zip_code)
    end

    test "email should be valid" do
        user = User.new(email: "test@example.com", password: "guest", username: "hello", zip_code: 11217)
        user.save
        email_valid_test(user)
    end

    test "email_encrypted should be unique" do
        user = User.new(email: "test@example.com", password: "guest", username: "hello", zip_code: 11217)
        user.save
        user = User.new(email: "test@example.com", password: "guest", username: "hello", zip_code: 11217)
        user.invalid?
        assert_equal "has already been taken", user.errors[:email_encrypted][0]
    end

    test "zip_code should be a number and five digits long" do
        user = users(:ben)
        zip_code_test(user)
    end
end
