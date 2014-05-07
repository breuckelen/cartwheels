require File.expand_path('../../test_helper', __FILE__)
class ReviewTest < ActiveSupport::TestCase
    fixtures :reviews

    test "text and rating may not be nil for a user" do
        rev = reviews(:review01)
        presence_test(rev, :text)
        presence_test(rev, :rating)
    end

    test "rating must be a valid number" do
        rev = reviews(:review01)
        numericality_test(rev, :rating)
    end
end
