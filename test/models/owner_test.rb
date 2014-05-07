require File.expand_path('../../test_helper', __FILE__)

class OwnerTest < ActiveSupport::TestCase
    fixtures :owners

    test "a valid email must be provided" do
        owner = owners(:echen)
        email_valid_test(owner)
    end
end
