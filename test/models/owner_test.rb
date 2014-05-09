require File.expand_path('../../test_helper', __FILE__)

class OwnerTest < ActiveSupport::TestCase
    fixtures :owners

    test "email, email_encrypted, password, password_encrypted should be present" do
        owner = owners(:echen)
        presence_test(owner, :email)
        presence_test(owner, :email_encrypted)
        presence_test(owner, :password)
        presence_test(owner, :password_encrypted)
    end

    test "email should be valid" do
        owner = Owner.new(email: "test@example.com", password: "guest")
        email_valid_test(owner)
    end

    test "email_encrypted should be unique" do
        owner = Owner.new(email: "test@example.com", password: "guest")
        owner.save
        owner = Owner.new(email: "test@example.com", password: "guest")
        owner.invalid?
        assert_equal "has already been taken", owner.errors[:email_encrypted][0]
    end
end
